--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

local settings = scavenger_settings;
local to_copper = scavenger.to_copper;

scavenger.add_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Money then
    local segments = { string.split("\n", slot.name) };
    local money = { gold = 0, silver = 0, copper = 0 };

    for _, raw_value in ipairs(segments) do
      local amount, value = string.split(" ", raw_value);
      money[string.lower(value)] = tonumber(amount) or 0;
    end

    local total_value = to_copper(money);
    return (
      this.money.min_value == nil or total_value >= to_copper(settings.money.min_value)
    ) and (
      this.money.max_value == nil or total_value <= to_copper(settings.money.max_value)
    );
  end
end);
