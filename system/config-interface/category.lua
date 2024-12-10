--[[~ Updated: 2024/12/10 | Author(s): Gopher ]]

--Backbone - A World of Warcraft addon framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

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
