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

---@class Backbone.ConfigPanel
local panel = {}
local prototype = { __index = panel }

---@protected
---@type Backbone.Plugin
panel.plugin = nil

---@protected
---@type Backbone.ConfigManager
panel.manager = nil

---@protected
---@type Backbone.ConfigCategory
panel.category = nil

---@param owner Backbone.Plugin
---@return Backbone.ConfigPanel
---Creates a configuration panel for the specified plugin.
---
ConfigPanel = function (owner)
  local manager, category = ConfigManager (owner)
  local configPanel = { plugin = owner, manager = manager, category = category }

  return setmetatable (configPanel, prototype)
end

---Returns the manager object for the configuration panel.
---
panel.getManager = function (self) return self.manager end

---Returns the category object for the configuration panel.
---
panel.getCategory = function (self) return self.category end

---@param options Backbone.ConfigPanel.HeaderOptions
---Creates a header for the configuration panel.
---
panel.createHeader = function (self, options)
  self.category:createHeader {
    text = self.plugin:getLocalizedString (options.label),
    tooltip = options.tooltip and self.plugin:getLocalizedString (options.label .. '-tooltip') or nil
  }
end

---@param options Backbone.ConfigPanel.ToggleOptions
---Creates a toggle that controls a setting with a boolean value.
---
panel.createToggle = function (self, options)
  self.category:createToggle {
    setting = options.setting,
    label = self.plugin:getLocalizedString (options.label),
    tooltip = options.tooltip and self.plugin:getLocalizedString (options.label .. '-tooltip') or nil
  }
end
