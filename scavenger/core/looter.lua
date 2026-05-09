--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

---------------------------------------------------------------------
-- ?

local loot_rules = {}

Scavenger.extend(
  "register_loot_rule", function(callback)
    if type(callback) ~= "function" then
      -- todo > print a warning
    else
      table.insert(loot_rules, callback)
    end
  end
)

---------------------------------------------------------------------
-- ?

Scavenger.add_event_hook(
  "LOOT_OPENED", function()
    local current_loot = {}
    local handled_slots = {}
    local slot_count = GetNumLootItems()

    if slot_count > 0 then
      for slot_index = 1, slot_count do
        local slot_type = GetLootSlotType(slot_index)

        if slot_type ~= Enum.LootSlotType.None then
          local slot_info = {
            GetLootSlotInfo(slot_index)
          }
          local icon = slot_info[1]
          local name = slot_info[2]
          local quantity = slot_info[3]
          local currency_id = slot_info[4]
          local is_locked = slot_info[6]
          local is_quest_item = slot_info[7]

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

          local item_link = GetLootSlotLink(slot_index)

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

          local decision = nil
          if not is_locked then
            for _, rule in ipairs(loot_rules) do
              local result = rule(slot_data)

              if type(result) == "boolean" then
                decision = result
                break -- no further processing required.
              end
            end
          end

          slot_data.autolooted = decision == true
          slot_data.ignored = decision == false

          local function immutable(target)
            local proxy = setmetatable(
              {}, {
                __index = function(_, key)
                  if key == "inspect" then
                    return function()
                      DevTools_Dump(target)
                    end
                  else
                    local value = target[key]

                    if type(value) ~= "table" then return value end
                    return immutable(value) -- ?
                  end
                end,

                __newindex = function()
                  -- todo > print warning
                end
              }
            )
            return proxy
          end

          current_loot[slot_index] = immutable(slot_data)

          if decision == true then
            LootSlot(slot_index) -- ?
          end
        end
      end

      x.invoke_listeners("LOOT_PROCESSED", current_loot)
    end

    -- ?

    local remove_loot_slot_cleared_listener
    remove_loot_slot_cleared_listener = Scavenger.add_event_hook(
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

    -- ?

    local remove_loot_closed_listener
    remove_loot_closed_listener = Scavenger.add_event_hook(
      "LOOT_CLOSED", function()
        handled_slots = {}

        remove_loot_slot_cleared_listener()
        remove_loot_closed_listener() -- cleanup.
      end
    )
  end
)
