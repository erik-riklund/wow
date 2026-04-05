--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

local _, this = ...;

this.settings = {
  --
  -- ?
  --
  junk = {
    min_value = { silver = 9, copper = 99 },
    max_value = { gold = 9, silver = 99 }
  },

  --
  -- ?
  --
  money = {
    min_value = { copper = 1 },
    max_value = { gold = 24, silver = 99, copper = 99 }
  },

  --
  -- ?
  --
  -- 1.  Parts
  -- 4.  Jewelcrafting
  -- 5.  Cloth
  -- 6.  Leather
  -- 7.  Metal & Stone
  -- 8.  Cooking
  -- 9.  Herb
  -- 10. Elemental
  -- 11. Other
  -- 12. Enchanting
  -- 16. Inscription
  -- 18. Optional Reagents
  -- 19. Finishing Reagents
  --
  reagents = {
    lootable_types = {
      { id = 4, quantity = { max = 1 } }, -- Jewelcrafting
      { id = 5, quantity = { max = 9 } }, -- Cloth
      { id = 6, quantity = { max = 9 } }, -- Leather
      { id = 7, quantity = { max = 9 } }, -- Metal & Stone
      { id = 9, quantity = { max = 9 } }, -- Herbs
    },
    quality_threshold = Enum.ItemQuality.Uncommon
  },

  --
  -- ?
  --
  -- { id = 130267, action = "ignore" }
  -- { id = 130267, quantity = { min = 2, max = 3 } }
  --
  items = {
    -- Classic -
    { id = 12363,  action = "ignore" }, -- Arcane Crystal
    { id = 58787,  action = "ignore" }, -- Crystal Bass (quest item)
    { id = 4235,   action = "ignore" }, -- Heavy Hide
    { id = 58856,  action = "ignore" }, -- Royal Monkfish (quest item)

    -- Northrend -
    { id = 36908,  action = "ignore" }, -- Frost Lotus

    -- Shadowlands -
    { id = 173204, action = "ignore" }, -- Lightless Silk
  },

  --
  -- ?
  --
  currencies = {}
};
