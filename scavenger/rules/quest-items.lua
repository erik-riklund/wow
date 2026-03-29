--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

scavenger.add_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item and slot.is_quest_item then
    return slot.item.stack_count > 1; -- loot non-unique quest items.
  end
end);
