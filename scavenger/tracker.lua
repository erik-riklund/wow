--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

scavenger.add_event_hook("ADDON_LOADED", function()
  local threshold = 10;
  local decay_rate = 0.5;
  local count_limit = 50;
  local seconds_per_day = 60 * 60 * 24;

  local now = GetTime();
  local today = date("%m/%d/%y");

  scavenger_loot = scavenger_loot or {}; -- saved variables.

  -- decay and purge existing items (once per day).
  if scavenger_loot.purged ~= today then
    scavenger_loot.purged = today;

    for link, data in pairs(scavenger_loot) do
      local days_passed = (now - data.last_looted) / seconds_per_day;
      local decayed_tally = math.floor(data.count * (decay_rate ^ days_passed));

      if decayed_tally < 1 then
        scavenger_loot[link] = nil; -- clear the item data from the cache.
      else
        scavenger_loot[link] = {
          count = decayed_tally,
          last_looted = data.last_looted
        };
      end
    end
  end

  -- create a loot rule based on the registry.
  scavenger.add_loot_rule(function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item;
      local item_data = scavenger_loot[item.link];

      if item_data ~= nil and item_data.count >= threshold then
        return true; -- instruct the controller to loot the item.
      end
    end
  end);

  scavenger.add_event_hook("LOOT_SLOT_CLEARED", function(slot_index)
    local slot = scavenger.get_slot_data(slot_index);

    if slot and not slot.ignored and slot.data.type == Enum.LootSlotType.Item then
      local item = slot.data.item;
      if item.bind_type == Enum.ItemBind.None then
        if scavenger_loot[item.link] == nil and not slot.autolooted then
          scavenger_loot[item.link] = {
            count = 1, last_looted = GetTime()
          };
        elseif scavenger_loot[item.link] ~= nil then
          scavenger_loot[item.link] = {
            count = math.min(scavenger_loot[item.link].count + 1, count_limit),
            last_looted = GetTime()
          };
        end
      end
    end
  end);
end);
