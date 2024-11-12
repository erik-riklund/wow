---@class Scavenger
local context = select(2, ...)

--[[~ Scavenger ~
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
    quest = {
      --
      -- Autoloot all quest items?
      -- If disabled, quest items will only be looted when they drop alone
      -- (e.g. from gathering objects) or if specified in the custom loot list.
      --
      lootAll = false,
    },

    ---
    --- Configuration options for managing tradeskill item looting.
    ---
    ---@class TradeskillLootOptions
    ---
    tradeskill = {
      --
      -- Determines the tradeskill item subtypes that should be looted.
      --
      lootableSubtypes = {
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
      qualityCap = Enum.ItemQuality.Rare,
    },

    ---
    --- Configuration options for managing currency looting behavior.
    ---
    ---@class CurrencyLootOptions
    ---
    currency = {
      --
      -- If enabled, money will be looted.
      --
      lootCoins = true,

      --
      -- Sets the maximum amount of gold to loot.
      --
      lootableGoldThreshold = 50,

      --
      -- ?
      --
      lootCurrencies = true,
    },

    ---
    --- Configuration options for managing junk item looting behavior.
    ---
    ---@class JunkLootOptions
    ---
    junk = {
      --
      -- The minimum value (in copper) of poor quality items to loot.
      --
      minimumValue = 1999, -- (1c)

      --
      -- The maximum value (in copper) of poor quality items to loot.
      --
      maximumValue = 99999, -- (9g 99s)
    },

    ---
    --- Configuration options for managing gear item looting behavior.
    ---
    ---@class GearLootOptions
    ---
    gear = {
      --
      -- Loot soulbound weapons and armor?
      --
      isEnabled = true,

      --
      -- The character's required minimum level for this to be active.
      --
      requiredPlayerLevel = 60,

      --
      -- If enabled, only items with known appearances will be looted.
      --
      lootOnlyKnownApperances = true,

      --
      -- If enabled, items from the current expansion will be looted.
      --
      lootGearFromCurrentExpansion = false,
    },

    ---
    --- Configuration options for managing custom loot behavior.
    ---
    ---@class CustomLootFilters
    ---
    filters = {
      --
      -- List of items to loot based on custom criteria.
      --
      loot = context.loot,

      --
      -- List of items to ignore based on custom criteria.
      --
      ignore = context.ignore,
    },
  })
end)
