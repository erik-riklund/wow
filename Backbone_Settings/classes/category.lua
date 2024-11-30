
--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

---@class SettingsCategory
local category = {}
local prototype = { __index = category }

---@protected
---@type Plugin
category.plugin = nil

---@protected
---@type Settings.VerticalLayoutCategory
category.object = nil

---@protected
---@type Settings.VerticalLayout
category.layout = nil

---?
category.getObject = function (self) return self.object end

---?
category.getLayout = function (self) return self.layout end

---@param options SettingsElement.Header
---?
category.createHeader = function (self, options)
  self.layout:AddInitializer(
    CreateSettingsListSectionHeaderInitializer(options.text, options.tooltip)
  )
end

---@param options SettingsElement.Checkbox
---?
category.createCheckbox = function (self, options)
  local plugin = self.plugin
  local default_value = self.plugin:getDefaultSetting (options.variable)

  local setting = Settings.RegisterProxySetting(
    self.object, options.variable, Settings.VarType.Boolean, options.label, default_value,
    function () return plugin:getSetting (options.variable) --[[@as boolean]] end,
    function (value) plugin:setSetting (options.variable, value) end
  )

  Settings.CreateCheckbox (self.object, setting, options.tooltip)
end

---@param plugin Plugin
---@param object Settings.VerticalLayoutCategory
---@param layout Settings.VerticalLayout
---?
SettingsCategory = function (plugin, object, layout)
  return setmetatable ({ plugin = plugin, object = object, layout = layout }, prototype)
end
