--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

local event_hooks = {
  addon_loaded = {},
  loot_opened = {},
  loot_closed = {},
  loot_slot_cleared = {},
};
local loot_rules = {};
local current_loot = nil;

-- Public API --

scavenger = {
  add_event_hook = function(event_name, callback)
    table.insert(event_hooks[string.lower(event_name)], callback);
  end,

  add_loot_rule = function(callback)
    table.insert(loot_rules, callback);
  end,

  to_copper = function(amount)
    local gold = amount.gold or 0;
    local silver = amount.silver or 0;
    local copper = amount.copper or 0;

    return copper + (silver * 100) + (gold * 10000);
  end,

  get_slot_data = function(index)
    return current_loot and current_loot[index];
  end
};

-- ? --

local event_frame = CreateFrame("Frame");

event_frame:RegisterEvent("ADDON_LOADED");
event_frame:RegisterEvent("LOOT_OPENED");
event_frame:RegisterEvent("LOOT_CLOSED");
event_frame:RegisterEvent("LOOT_SLOT_CLEARED");

event_frame:SetScript("OnEvent", function(_, event_name, ...)
  if event_name == "ADDON_LOADED" then
    local addon_name = ...;
    if addon_name ~= "Scavenger" then
      return; -- early exit.
    end
  end

  for _, callback in ipairs(event_hooks[string.lower(event_name)]) do
    callback(...); -- invoke each hook in the order they are registered.
  end
end);

-- ? --

scavenger.add_event_hook("LOOT_OPENED", function()
  local slot_count = GetNumLootItems();
  current_loot = {}; -- reset the loot registry.

  if slot_count > 0 then
    for slot_index = 1, slot_count do
      local slot_type = GetLootSlotType(slot_index);
      local _, name, quantity, currency_id, _, is_locked, is_quest_item = GetLootSlotInfo(slot_index);

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
  end
end);
