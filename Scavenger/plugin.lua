---@class Scavenger
local context = select(2, ...)

--[[~ Plugin: Scavenger ~
  Updated: 2024/10/26 | Author(s): Erik Riklund (Gopher)
]]

context.plugin = backbone.createPlugin('Scavenger', {
  storage = { account = true, character = true },
})

context.plugin:onLoad(function()
  context.config = backbone.useConfigManager(context.plugin, {
    ---
    --- Configuration options for managing quest item looting behavior.
    --- 
    ---@class QuestLootOptions
    ---
    QUEST = {
      --
      -- Autoloot all quest items?
      -- If disabled, quest items will only be looted when they drop alone
      -- (e.g. from gathering objects) or if specified in the custom loot list.
      --
      LOOT_ALL = false,
    },

    ---
    --- Configuration options for managing tradeskill item looting.
    ---
    ---@class TradeskillLootOptions
    ---
    TRADESKILL = {
      --
      -- Determines the tradeskill item subtypes that should be looted.
      --
      SUBTYPES = {
        [backbone.enums.TradeskillSubType.Cloth] = true,
        [backbone.enums.TradeskillSubType.Cooking] = true,
        [backbone.enums.TradeskillSubType.Enchanting] = true,
        [backbone.enums.TradeskillSubType.Herb] = true,
        [backbone.enums.TradeskillSubType.Inscription] = true,
        [backbone.enums.TradeskillSubType.Leather] = true,
        [backbone.enums.TradeskillSubType.MetalAndStone] = true,
      },

      --
      -- Determines the quality cap for tradeskill items that should be looted.
      --
      QUALITY_CAP = Enum.ItemQuality.Rare,
    },

    ---
    --- Configuration options for managing currency looting behavior.
    --- 
    ---@class CurrencyLootOptions
    ---
    CURRENCY = {
      --
      -- Sets the maximum amount of gold to loot.
      --
      GOLD_MAX = 50,
    },

    ---
    --- Configuration options for managing junk item looting behavior.
    ---
    ---@class JunkLootOptions
    ---
    JUNK = {
      --
      -- The minimum value (in copper) of poor quality items to loot.
      --
      MIN_VALUE = 1, -- (1c)

      --
      -- The maximum value (in copper) of poor quality items to loot.
      --
      MAX_VALUE = 99999, -- (9g 99s)
    },

    ---
    --- Configuration options for managing gear item looting behavior.
    ---
    ---@class GearLootOptions
    ---
    GEAR = {
      --
      -- Loot soulbound weapons and armor?
      --
      ENABLED = true,

      --
      -- The character's required minimum level for this to be active.
      --
      PLAYER_LEVEL = 60,

      --
      -- If enabled, only items with known appearances will be looted.
      --
      ONLY_KNOWN = true,

      --
      -- If enabled, items from the current expansion will be looted.
      --
      CURRENT_EXPANSION = false,
    },

    ---
    --- Configuration options for managing custom loot behavior.
    --- 
    ---@class CustomLootFilters
    ---
    FILTERS = {
      --
      -- List of items to loot based on custom criteria.
      --
      LOOT = context.loot,

      --
      -- List of items to ignore based on custom criteria.
      --
      IGNORE = context.ignore,
    },
  })
end)
