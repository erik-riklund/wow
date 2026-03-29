--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

local settings = scavenger_settings;

scavenger.add_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item then
    local item = slot.item;

    if item.type_id == Enum.ItemClass.Tradegoods then
      local rule = nil;
      for _, current_rule in ipairs(settings.reagents.lootable_types) do
        if current_rule.id == item.subtype_id then
          rule = current_rule;
          break;
        end
      end

      if rule ~= nil then
        local quality_threshold = settings.reagents.quality_threshold;
        if rule.quality_threshold ~= nil then
          quality_threshold = rule.quality_threshold;
        end

        if item.quality > quality_threshold then
          return false; -- ?
        end
        if type(rule.quantity) ~= "table" then
          return true; -- ?
        end

        if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
          return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
              and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max);
        end
      end
    end
  end
end);
