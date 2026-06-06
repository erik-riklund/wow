--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

--
-- # Quest item rule processing
--
-- Evaluates items explicitly flagged by the game client as quest items.
--
-- Items with a maximum stack count of 1 are ignored. This leaves them to be
-- looted manually, preserving the rewarding feeling of clicking a rare item.
--

scavenger.register_loot_rule(
  {
    test = function(slot)
      return slot.type == Enum.LootSlotType.Item and slot.is_quest_item
    end,

    evaluate = function(slot)
      return slot.item.stack_count > 1 -- Loot non-unique quest items.
    end
  }
)
