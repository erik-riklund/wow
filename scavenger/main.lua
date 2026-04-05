--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

_G.scavenger = {}; -- the public API.

--
-- # ?
--
-- ...
--

local frame = CreateFrame("Frame");
local event_hooks = {}; -- contains the listeners for each event.

frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("LOOT_OPENED");
frame:RegisterEvent("LOOT_CLOSED");
frame:RegisterEvent("LOOT_SLOT_CLEARED");

local function invoke_listeners(event_name, ...)
  if event_hooks[event_name] then
    for _, callback in ipairs(event_hooks[event_name]) do
      callback(...); -- invoke each hook in the order they are registered.
    end
  end
end

frame:SetScript("OnEvent", function(_, event_name, ...)
  if event_name == "ADDON_LOADED" then
    local addon_name = ...;
    if addon_name ~= "Scavenger" then
      return; -- early exit.
    end
  end
  invoke_listeners(event_name, ...);
end);

function scavenger.add_event_hook(event_name, callback)
  if not event_hooks[event_name] then
    event_hooks[event_name] = {};
  end
  table.insert(event_hooks[event_name], callback);
end

--
-- # ?
--
-- ...
--

local loot_rules = {};    -- ?
local current_loot = nil; -- used to store data about the current loot.

function scavenger.add_loot_rule(callback)
  table.insert(loot_rules, callback);
end

scavenger.add_event_hook("LOOT_OPENED", function()
  local slot_count = GetNumLootItems();
  current_loot = {}; -- reset the loot data table.

  if slot_count > 0 then
    for slot_index = 1, slot_count do
      local slot_type = GetLootSlotType(slot_index);
      local slot_info = { GetLootSlotInfo(slot_index) };

      local name = slot_info[2];
      local quantity = slot_info[3];
      local currency_id = slot_info[4];
      local is_locked = slot_info[6];
      local is_quest_item = slot_info[7];

      if not is_locked and slot_type ~= Enum.LootSlotType.None then
        local slot_data = {
          type = slot_type,
          name = name,
          quantity = quantity,
          currency_id = currency_id,
          is_quest_item = is_quest_item,
          is_fishing_loot = IsFishingLoot()
        };
        local item_link = GetLootSlotLink(slot_index);

        if item_link then
          local item_data = {
            C_Item.GetItemInfo(item_link)
          };

          slot_data.item = {
            link = item_data[2],
            quality = item_data[3],
            stack_count = item_data[8],
            sell_price = item_data[11],
            type_id = item_data[12],
            subtype_id = item_data[13],
            bind_type = item_data[14],
            expansion_id = item_data[15]
          };
        end

        local decision = nil;
        for _, rule in ipairs(loot_rules) do
          local result = rule(slot_data);
          if type(result) == "boolean" then
            decision = result;
            break; -- no further processing required.
          end
        end

        current_loot[slot_index] = {
          index = slot_index,
          data = slot_data,
          autolooted = decision == true,
          ignored = decision == false
        };

        if decision == true then
          LootSlot(slot_index);
        end
      end
    end

    invoke_listeners("LOOT_PROCESSED", current_loot);
  end
end);

--
-- # ?
--
-- ...
--

local handled_slots = {}; -- ?

scavenger.add_event_hook("LOOT_CLOSED",
  function() handled_slots = {} end
);

scavenger.add_event_hook("LOOT_SLOT_CLEARED", function(index)
  if not handled_slots[index] then
    handled_slots[index] = true;
    if current_loot then
      invoke_listeners("SLOT_LOOTED", current_loot[index]);
    end
  end
end);

--
-- # ?
--
-- ...
--

scavenger.add_event_hook("ADDON_LOADED", function()
  local variables = __scavenger or {};
  __scavenger = variables; -- ensures the saved variables are persisted.

  function scavenger.get_variable(path)
    local steps = { string.split("/", string.sub(path, 2)) };
    local property = table.remove(steps); -- the last element.

    local reference = variables;
    for _, current_step in ipairs(steps) do
      if reference[current_step] == nil then
        return nil; -- ?
      end
      reference = reference[current_step];
    end
    return reference[property];
  end

  function scavenger.set_variable(path, value)
    local steps = { string.split("/", string.sub(path, 2)) };
    local property = table.remove(steps); -- the last element.

    local reference = variables;
    for _, current_step in ipairs(steps) do
      if reference[current_step] == nil then
        reference[current_step] = {}; -- ?
      end
      reference = reference[current_step];
    end

    reference[property] = value;
  end
end);
