--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

--- @class context
local x = select(2, ...)

x.settings = {
  --
  -- # Poor quality item vendor thresholds
  --
  -- Defines the acceptable range of vendor sell values for auto-looting grey items.
  -- Items with a total value below `min_value` or above `max_value` will be bypassed.
  --

  junk = {
    min_value = { copper = 1 },
    max_value = { gold = 4, silver = 99 }
  },

  --
  -- # Raw money loot thresholds
  --
  -- Controls the minimum and maximum boundaries for automatically
  -- scooping up raw coin drops from loot targets.
  --

  money = {
    min_value = { copper = 1 },
    max_value = { gold = 24, silver = 99, copper = 99 }
  },

  --
  -- # Item blacklist exception registry
  --
  -- Hardcoded explicit overrides for specific item IDs.
  -- Used to enforce a static action (e.g., "ignore") regardless of standard item
  -- quality, type, or value rules. Supports quantity range validation constraints.
  --
  -- { id = 130267, action = "ignore" }
  -- { id = 130267, quantity = { min = 2, max = 3 } }
  --

  items =
  {
    -- Classic -
    { id = 58787,  action = "ignore" }, -- Crystal Bass (quest item)
    { id = 4235,   action = "ignore" }, -- Heavy Hide
    { id = 13893,  action = "ignore" }, -- Large Raw Mightfish
    { id = 783,    action = "ignore" }, -- Light Hide
    { id = 4232,   action = "ignore" }, -- Medium Hide
    { id = 58856,  action = "ignore" }, -- Royal Monkfish (quest item)
    { id = 8171,   action = "ignore" }, -- Rugged Hide
    { id = 10285,  action = "ignore" }, -- Shadow Silk
    { id = 3182,   action = "ignore" }, -- Spider's Silk
    { id = 8169,   action = "ignore" }, -- Thick Hide
    { id = 4337,   action = "ignore" }, -- Thick Spider's Silk

    -- Northrend -
    { id = 36908,  action = "ignore" }, -- Frost Lotus

    -- Legion -
    { id = 124439, action = "loot" }, -- Unbroken Tooth

    -- Shadowlands -
    { id = 173204, action = "ignore" }, -- Lightless Silk
    { id = 171830, action = "loot" },   -- Oxxein Ore
    { id = 171841, action = "loot" },   -- Shaded Stone
  },

  --
  -- # Crafting reagent filtering profile
  --
  -- Handles auto-loot parameters for specific trade skill materials based on
  -- their subclass IDs (e.g., 4 for Jewelcrafting, 9 for Herbs).
  --
  -- Settings for stack sizes are entirely optional; a reagent profile can be configured
  -- to restrict filtering strictly to quality requirements. A global quality threshold
  -- acts as the baseline fallback, but individual entries can specify their own standalone
  -- quality or quantity constraints.
  --
  -- [ https://warcraft.wiki.gg/wiki/ItemType ]
  --

  reagents =
  {
    lootable_types =
    {
      {
        id = 4, -- Jewelcrafting
        quantity = { max = 1 }
      },
      {
        id = 5, -- Cloth
        quantity = { max = 19 }
      },

      { id = 6 },  -- Leather
      { id = 7 },  -- Metal & Stone
      { id = 9, }, -- Herbs
    },

    quality_threshold = Enum.ItemQuality.Common
  },

  --
  -- # ?
  --
  -- ...
  --

  currency =
  {
    -- The War Within
    { id = 2815, quantity = { max = 50 } } -- Resonance Crystals
  }
}
