--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger-lootframe (2026)

local test_items = {
  { "|cffffffff|Hitem:2447::::::::60:::::|h[Peacebloom]|h|r",                                    132 },
  { "|cff9d9d9d|Hitem:7073::::::::90:::::|h[Broken Fang]|h|r",                                   4 },
  { "|cffff8000|Hitem:19019::::::::90:::::|h[Thunderfury, Blessed Blade of the Windseeker]|h|r", 1 },

  -- { "|cffa335ee|Hitem:2244::::::::90:::::|h[Krol Blade]|h|r",                                    1 },
  -- { "|cffa335ee|Hitem:12895::::::::90:::::|h[Breastplate of the Chromatic Flight]|h|r",          1 },
  -- { "|cffffffff|Hitem:25::::::::90:::::|h[Worn Shortsword]|h|r", 1 },
  -- { "|cff0070dd|Hitem:24252::::::::90:::::|h[Cloak of the Black Void]|h|r",                      1 },
  -- { "|cffffffff|Hitem:44607::::::::90:::::|h[Aged Dalaran Sharp]|h|r",                           3 },
  -- { "|cffffffff|Hitem:1434::::::::90:::::|h[Glowing Wax Stick]|h|r",                             2 },
  -- { "|cff1eff00|Hitem:264878::::::::90:::::|h[Astalor's Anguish Agitator]|h|r",                  1 },
  -- { "|cffa335ee|Hitem:256424::::::::90:::::|h[Echo of Aln'sharan]|h|r", 1 },
  -- { "|cffffffff|Hitem:4499::::::::90:::::|h[Huge Brown Sack]|h|r",                               1 },
  -- { "|cffffffff|Hitem:139436::::::::90:::::|h[Glyph of Tattered Wings]|h|r",                     1 },
  -- { "|cff0070dd|Hitem:212786::::::::90:::::|h[Lovely Duckling]|h|r",                             1 },
  -- { "|cff9d9d9d|Hitem:43644::::::::90:::::|h[A Peasant's Silver Coin]|h|r",                      1 },
  -- { "|cffffffff|Hitem:115498::::::::90:::::|h[Ashran Healing Tonic]|h|r",                        25 },
  -- { "|cffffffff|Hitem:192548::::::::90:::::|h[Cindershard Coal]|h|r",                            3 }
};

local test_slots = {};
for index, item in ipairs(test_items) do
  local link, quantity = unpack(item);
  local item_info = { C_Item.GetItemInfo(link) };

  local slot = {
    index = index,
    type = Enum.LootSlotType.Item,
    name = item_info[1],
    icon = item_info[10],
    quantity = quantity,

    item = {
      link = link,
      quality = item_info[3],
      localized_type = item_info[6],
      localized_subtype = item_info[7],
      stack_count = item_info[8],
      equip_location = item_info[9],
      sell_price = item_info[11],

      type_id = item_info[12],
      subtype_id = item_info[13],
      bind_type = item_info[14],
      expansion_id = item_info[15],

      expansion_name = _G["EXPANSION_NAME" .. item_info[15]],
      actual_level = C_Item.GetDetailedItemLevelInfo(link),
      is_collected = C_TransmogCollection.PlayerHasTransmogByItemInfo(link)
    },

    is_fishing_loot = false,
    is_quest_item = false,
    is_locked = false,
    autolooted = false,
    ignored = false
  };

  table.insert(test_slots, slot);
end

-- test_slots[3].is_locked = true; -- Thunderfury, Blessed Blade of the Windseeker
-- test_slots[11].is_locked = true;     -- Echo of Aln'sharan
-- test_slots[17].is_quest_item = true; -- Cindershard Coal

-- todo > add currency slots.

render_loot_frame(test_slots);
