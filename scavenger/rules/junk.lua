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
  if slot.type == Enum.LootSlotType.Item then
    local item = slot.item;

    if item.quality == Enum.ItemQuality.Poor then
      if item.bind_type == Enum.ItemBind.None or item.stack_count > 1 then
        local total_value = item.sell_price * slot.quantity;
        local is_lootable = (
          slot.is_fishing_loot or total_value >= to_copper(settings.junk.min_value)
        ) and total_value <= to_copper(settings.junk.max_value);

        if is_lootable then return true end
      end
    end
  end
end);
