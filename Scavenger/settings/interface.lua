---@class Scavenger
local context = select(2, ...)

--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

backbone.onAddonLoaded (
  'Scavenger', function ()
    local _, category = SettingsManager (context.plugin)

    category:createCheckbox {
      variable = 'QUEST/LOOT_ALL', label = '?',
      tooltip = '?'
      
      -- TODO: replace the explicit strings with localized versions.
    }
  end
)
