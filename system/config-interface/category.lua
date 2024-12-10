
--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

---@class Backbone.ConfigCategory
local category = {}
local prototype = { __index = category }

---@protected
---@type Backbone.Plugin
category.plugin = nil

---@protected
---@type Settings.VerticalLayoutCategory
category.object = nil

---@protected
---@type Settings.VerticalLayout
category.layout = nil

---Returns the object associated with the category.
---
category.getObject = function (self) return self.object end

---Returns the layout associated with the category.
---
category.getLayout = function (self) return self.layout end

---@param options Backbone.ConfigElement.Header
---Create a section header within the category.
---
category.createHeader = function (self, options)
  self.layout:AddInitializer(
    CreateSettingsListSectionHeaderInitializer(options.text, options.tooltip)
  )
end

---@param options Backbone.ConfigElement.Checkbox
---Create a toggle that controls a setting with a boolean value.
---
category.createToggle = function (self, options)
  local plugin = self.plugin
  local defaultValue = self.plugin:getDefaultSetting (options.setting)

  local setting = Settings.RegisterProxySetting(
    self.object, options.setting, Settings.VarType.Boolean, options.label, defaultValue,
    function () return plugin:getSetting (options.setting) --[[@as boolean]] end,
    function (value) plugin:setSetting (options.setting, value) end
  )

  Settings.CreateCheckbox (self.object, setting, options.tooltip)
end

---@param plugin Backbone.Plugin
---@param object Settings.VerticalLayoutCategory
---@param layout Settings.VerticalLayout
---Create a category that can contain a set of configuration options.
---
SettingsCategory = function (plugin, object, layout)
  return setmetatable ({ plugin = plugin, object = object, layout = layout }, prototype)
end
