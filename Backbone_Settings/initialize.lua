---@class Backbone_Settings
local context = select(2, ...)

--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---debug: dumping the Settings table
-- for key, value in pairs(_G['Settings']) do
--   print (string.format ('[%s] = %s (%s)', key, tostring (value), type (value)))
-- end

-- for key, value in pairs(Settings.VarType) do
--   print (string.format ('[%s] = %s (%s)', key, tostring (value), type (value)))
-- end

---@class SettingsManager
context.manager = {}

---@protected
---@type Settings.VerticalLayoutCategory
context.manager.categories = nil

---@protected
---@type table
context.manager.layout = nil

---?
local prototype = { __index = context.manager }

---@param plugin Plugin
---?
SettingsManager = function (plugin)
  local category, layout = Settings
    .RegisterVerticalLayoutCategory(string.gsub (plugin:getName(), '_', ' '))

  -- TODO: evaluate if we need to keep the layout.
  
  EventUtil.ContinueOnAddOnLoaded(plugin:getName(),
    function () Settings.RegisterAddOnCategory (category) end
  )
  
  return setmetatable ({ category = category, layout = layout }, prototype)
end
