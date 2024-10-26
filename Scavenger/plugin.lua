---@class Scavenger
local context = select(2, ...)

--[[~ Plugin: Scavenger ~
  Updated: 2024/10/26 | Author(s): Erik Riklund (Gopher)
]]

local ITEM_QUALITY = backbone.enums.ITEM_QUALITY
local TRADESKILL_SUBTYPE = backbone.enums.TRADESKILL_SUBTYPE

local plugin = backbone.createPlugin('Scavenger', {
  storage = { account = true, character = true },
})

plugin:onLoad(function()
  context.config = backbone.useConfigManager(plugin, {
    --
    -- Configuration options for managing quest item looting behavior.
    --
    QUEST = {
      --
      -- Autoloot all quest items?
      -- If disabled, quest items will only be looted when they drop alone
      -- (e.g. from gathering objects) or if specified in the custom loot list.
      --
      LOOT_ALL = false,
    },

    --
    -- Configuration options for managing tradeskill item looting.
    --
    TRADESKILL = {
      --
      -- Determines the tradeskill item subtypes that should be looted.
      --
      SUBTYPES = {
        TRADESKILL_SUBTYPE.CLOTH,
        TRADESKILL_SUBTYPE.HERB,
        TRADESKILL_SUBTYPE.LEATHER,
        TRADESKILL_SUBTYPE.METAL_AND_STONE,
      },

      --
      -- Determines the quality cap for tradeskill items that should be looted.
      --
      QUALITY_CAP = ITEM_QUALITY.RARE,
    },

    --
    -- Configuration options for managing currency looting behavior.
    --
    CURRENCY = {
      --
      -- Sets the maximum amount of gold to loot.
      --
      GOLD_MAX = 50,
    },

    --
    -- Configuration options for managing junk item looting behavior.
    --
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

    --
    -- Configuration options for managing gear item looting behavior.
    --
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
    },

    --
    -- Configuration options for managing custom loot behavior.
    --
    CUSTOM = {
      --
      -- List of items to loot based on custom criteria.
      --
      LOOT = {},

      --
      -- List of items to ignore based on custom criteria.
      --
      IGNORE = {},
    },
  })
end)
