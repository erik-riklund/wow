---@class Scavenger
local context = select(2, ...)

--[[~ Updated: 2024/11/21 | Author(s): Erik Riklund (Gopher) ]]

---
--- Create the plugin.
---
context.plugin = backbone.createPlugin 'Scavenger'

---
--- Create the channel used to broadcast a list of items that remains
--- after the looting process is completed.
---
context.plugin:createChannel 'LOOT_PROCESSED'

---
--- Defines the default settings for the plugin.
---
context.plugin:registerDefaultSettings(
  new('Dictionary',
  {
    ---@class QuestLootOptions
    QUEST =
    {
      -- Autoloot all quest items?
      LOOT_ALL = false
    },

    ---@class TradeskillLootOptions
    TRADESKILL =
    {
      -- Determines the quality cap for lootable tradeskill items.
      QUALITY_CAP = E_ITEM_QUALITY.RARE,

      -- Determines the tradeskill item subtypes that should be looted.
      LOOTABLE_SUBTYPES =
      {
        [E_TRADESKILL_SUBTYPE.ENCHANTING]      = true,
        [E_TRADESKILL_SUBTYPE.HERB]            = true,
        [E_TRADESKILL_SUBTYPE.INSCRIPTION]     = true,
        [E_TRADESKILL_SUBTYPE.LEATHER]         = true,
        [E_TRADESKILL_SUBTYPE.METAL_AND_STONE] = true
      }
    },

    ---@class CurrencyLootOptions
    CURRENCY =
    {
      -- If enabled, money will be looted.
      LOOT_COINS = true,

      -- Defines the maximum amount of gold to loot.
      GOLD_THRESHOLD = 50,

      -- If enabled, currencies will be looted.
      LOOT_CURRENCIES = true
    },

    ---@class JunkLootOptions
    JUNK =
    {
      -- The minimum value (in copper) of poor quality items to loot.
      MINIMUM_VALUE = 100,

      -- The maximum value (in copper) of poor quality items to loot.
      MAXIMUM_VALUE = 99999
    },

    ---@class GearLootOptions
    GEAR = 
    {
      -- Loot soulbound weapons and armor?
      ENABLED = true,

      -- The character's required minimum level for this to be active.
      PLAYER_LEVEL = 60,

      -- If enabled, only items with known appearances will be looted.
      ONLY_KNOWN = true,

      -- If enabled, items from the current expansion will be looted.
      CURRENT_EXPANSION = false
    },

    ---@class LootFilters
    FILTERS = { LOOT = context.loot, IGNORE = context.ignore }
  })
)
