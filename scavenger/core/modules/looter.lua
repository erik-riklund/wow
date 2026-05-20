--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

--
-- # Loot evaluation rules
--
-- Keeps track of registered auto-loot filter rules.
-- Rules are processed in the order they were registered.
--

local loot_rules = {}

scavenger.extend(
  "register_loot_rule", function(rule)
    if type(rule) ~= "table" then
      -- todo > print a warning (rule must be an object)
    else
      table.insert(loot_rules, rule)
    end
  end
)

--
-- # Loot initialization and processing engine
--
-- Runs automatically as soon as the player interacts with a lootable source.
-- Evaluates every slot against registered rules to auto-loot items, and builds
-- a read-only list of remaining slots to hand off to event listeners.
--

scavenger.add_event_hook(
  "LOOT_OPENED", function()
    local current_loot = {}  -- Temporary cache tracking the data of every slot in this loot window.
    local handled_slots = {} -- Map storing index strings of cleared slots to prevent double-firing events.

    -- Ensure we actually have items to evaluate before kicking off the pipeline.

    local slot_count = GetNumLootItems()

    if slot_count > 0 then
      for slot_index = 1, slot_count do
        local slot_type = GetLootSlotType(slot_index)

        if slot_type ~= Enum.LootSlotType.None then
          --
          -- Retrieve base slot data.

          local slot_info = {
            GetLootSlotInfo(slot_index)
          }

          local icon = slot_info[1]
          local name = slot_info[2]
          local quantity = slot_info[3]
          local currency_id = slot_info[4]
          local is_locked = slot_info[6]
          local is_quest_item = slot_info[7]

          -- Package the base slot data into a unified, descriptive table.

          local slot_data = {
            type = slot_type,
            name = name,
            icon = icon,
            quantity = quantity,
            currency_id = currency_id,
            index = slot_index,

            is_locked = is_locked,
            is_quest_item = is_quest_item,
            is_fishing_loot = IsFishingLoot()
          }

          -- Grab the unique item link from the slot to look up item-specific details.

          local item_link = GetLootSlotLink(slot_index)

          -- If this is a valid item link, query the game database to enrich
          -- our slot details with attributes like quality, type, and sell value.

          if item_link then
            local item_data = {
              C_Item.GetItemInfo(item_link)
            }

            slot_data.item = {
              link = item_data[2],
              quality = item_data[3],
              localized_type = item_data[6],
              localized_subtype = item_data[7],
              stack_count = item_data[8],
              equip_location = item_data[9],
              sell_value = item_data[11],

              type_id = item_data[12],
              subtype_id = item_data[13],
              bind_type = item_data[14],
              expansion_id = item_data[15],

              expansion_name = _G["EXPANSION_NAME" .. item_data[15]],
              actual_level = C_Item.GetDetailedItemLevelInfo(item_link),
              is_collected = C_TransmogCollection.PlayerHasTransmogByItemInfo(item_link)
            }
          end

          -- Match the slot data against our evaluation rules to
          -- decide whether to auto-loot it (true) or ignore it (false).

          local decision = nil
          if not is_locked then
            for _, rule in ipairs(loot_rules) do
              if rule.test(slot_data) then
                local result = rule.evaluate(slot_data)

                if type(result) == "boolean" then
                  decision = result
                  break -- Exit early as soon as a rule takes ownership of the item.
                end
              end
            end
          end

          -- Flag the final rule outcome directly in the slot data.

          slot_data.autolooted = decision == true
          slot_data.ignored = decision == false

          -- A utility function that wraps our slot table in a deep proxy metatable.
          -- This prevents other modules from accidentally mutating the slot data.

          local function immutable(target)
            local proxy = setmetatable(
              {}, {
                --
                -- Handles property lookups. If the 'inspect' key is called, we return
                -- a utility helper to dump the raw table. Otherwise, we return the value,
                -- recursively wrapping nested child tables in this same read-only proxy.

                __index = function(_, key)
                  if key == "inspect" then
                    return function()
                      DevTools_Dump(target)
                    end
                  else
                    local value = target[key]

                    if type(value) ~= "table" then return value end
                    return immutable(value) -- Recursively freeze nested tables.
                  end
                end,

                -- Intercepts any direct write or edit attempts,
                -- warning the developer that the slot state is read-only.

                __newindex = function()
                  scavenger.warn("Blocked attempt to modify read-only slot data")
                end
              }
            )
            return proxy
          end

          -- Cache the frozen, read-only slot data in our temporary loot tracker.

          current_loot[slot_index] = immutable(slot_data)

          -- If an active auto-loot rule returned true,
          -- instruct the game client to loot the item from this slot.

          if decision == true then LootSlot(slot_index) end
        end
      end

      -- Dispatch our newly processed and compiled list of slots to any active
      -- event listeners (such as our sorting engine or custom logging UI).

      x.invoke_listeners("LOOT_PROCESSED", current_loot)
    end

    -- Hook into cleared slot events. This captures precisely which slot the player
    -- looted, allowing external modules to display alerts, log items, or track statistics.

    local remove_loot_slot_cleared_listener
    remove_loot_slot_cleared_listener = scavenger.add_event_hook(
      "LOOT_SLOT_CLEARED", function(index)
        local stringified_index = tostring(index)

        if not handled_slots[stringified_index] then
          if current_loot then
            x.invoke_listeners("SLOT_LOOTED", current_loot[index])
          end
          handled_slots[stringified_index] = true
        end
      end
    )

    -- Listen for when the loot window closes to clean up state trackers and
    -- disconnect temporary event hooks to free up memory.

    local remove_loot_closed_listener
    remove_loot_closed_listener = scavenger.add_event_hook(
      "LOOT_CLOSED", function()
        handled_slots = {}

        remove_loot_slot_cleared_listener()
        remove_loot_closed_listener()
      end
    )
  end
)
