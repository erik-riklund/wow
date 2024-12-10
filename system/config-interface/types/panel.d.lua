---@meta

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

---@class Backbone.ConfigPanel.HeaderOptions
---@field label string The key of the localized string to use for the header's label.
---@field tooltip? boolean Specifies whether to include a tooltip for the header.

---@class Backbone.ConfigPanel.ToggleOptions
---@field setting string The key of the setting to toggle. Must be a boolean setting.
---@field label string The key of the localized string to use for the toggle's label.
---@field tooltip? boolean Specifies whether to include a tooltip for the toggle.
