
--[[~ Updated: 2024/12/04 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

---Enumerations provided by the Backbone framework.
_G.ENUM = {}

---The main API for the Backbone framework.
_G.backbone = {}

---@type LocaleCode
---The current active locale.
backbone.activeLocale = GetLocale()

---@type EXPANSION_LEVEL
---The current expansion level.
backbone.currentExpansion = GetExpansionLevel()
