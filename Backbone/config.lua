---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

context.plugin:registerDefaultSettings { development = false }

EventUtil.ContinueOnAddOnLoaded(
  'Backbone_Settings', function ()
    local _, category = SettingsManager (context.plugin)
    
    category:createCheckbox {
      variable = 'development', label = 'Development mode',
      tooltip = 'Development mode enables more detailed error reporting and debugging.'
    }
  end
)
