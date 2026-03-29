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

    local rule = nil;
    for _, current_rule in ipairs(settings.items) do
      local _, link = C_Item.GetItemInfo(current_rule.id);
      if link == item.link then
        rule = current_rule;
        break;
      end
    end

    if rule ~= nil then
      if type(rule.action) == "string" then
        return rule.action ~= "ignore";   -- returns false if the item should be ignored.
      end

      if type(rule.quantity) == "table" then
        if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
          return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
              and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max);
        end
      end
    end
  end
end);
