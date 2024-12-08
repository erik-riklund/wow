---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/05 | Author(s): Gopher ]]

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

---
---The ENUM table contains the enumeration values introduced by the framework.
---
ENUM = {}

---The main API for the Backbone framework.
---
_G.backbone = {}

---The currently active locale, represented as a string.
---
backbone.activeLocale = GetLocale() --[[@as LocaleCode]]

---The currently active expansion level, represented as an `EXPANSION_LEVEL` enum value.
---
backbone.currentExpansion = GetExpansionLevel() --[[@as EXPANSION_LEVEL]]

---A frame used internally by the framework to handle events and scripts.
---
context.frame = CreateFrame ('Frame', 'BackboneFrame', UIParent)

---@param message string
---@param ... string
---Throws an error with the provided message.
---* Formatting can be used by passing additional arguments.
---
backbone.throw = function (message, ...)
  local exception = (... and string.format(message, ...)) or message
  error (string.format ('[Backbone] %s', exception), 3)
end
