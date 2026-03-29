--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

scavenger.add_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item and slot.is_fishing_loot then
    local item = slot.item;
    local cooking_reagent = 8;

    if item.type_id == Enum.ItemClass.Tradegoods and item.subtype_id == cooking_reagent then
      return true; -- loot edible fish caught while fishing.
    end
  end
end);
