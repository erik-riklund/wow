--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

local threshold = 3;
local decay_rate = 0.5;
local count_limit = 10;
local seconds_per_day = 60 * 60 * 24;

--
-- # ?
--
-- ...
--

local now = GetTime();
local today = date("%m/%d/%y");
local last_purge = scavenger.get_variable("/habit/last_purge");
local registry = scavenger.get_variable("/habit/registry");

if not registry then
  registry = {}; -- initialize the table used to track looted items.
  scavenger.set_variable("/habit/registry", registry);
end

if last_purge ~= today then
  scavenger.set_variable("/habit/last_purge", today);

  for link, data in pairs(registry) do
    local days_passed = (now - data.last_looted) / seconds_per_day;
    local decayed_tally = math.floor(data.count * (decay_rate ^ days_passed));

    if decayed_tally < 1 then
      registry[link] = nil; -- clear the item data from the cache.
    else
      registry[link] = {
        count = decayed_tally,
        last_looted = data.last_looted
      };
    end
  end
end

--
-- # ?
--
-- ...
--

scavenger.add_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item then
    local item = slot.item;
    local item_data = registry[item.link];

    if item_data and item_data.count >= threshold then
      return true; -- instruct the controller to loot the item.
    end
  end
end);

--
-- # ?
--
-- ...
--

scavenger.add_event_hook("SLOT_LOOTED", function(slot)
  if slot and not slot.ignored and slot.data.type == Enum.LootSlotType.Item then
    local item = slot.data.item;
    if item.bind_type == Enum.ItemBind.None then
      if registry[item.link] == nil and not slot.autolooted then
        registry[item.link] = {
          count = 1, last_looted = GetTime()
        };
      elseif registry[item.link] ~= nil then
        registry[item.link] = {
          count = math.min(registry[item.link].count + 1, count_limit),
          last_looted = GetTime()
        };
      end
    end
  end
end);
