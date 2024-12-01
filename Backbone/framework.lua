---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/01 | Author(s): Gopher ]]

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

---?
_G.ENUM = {}

---?
context.frame = CreateFrame 'Frame'

---The API for the Backbone framework.
_G.backbone = {
  ---The active locale of the game client, represented as a string (e.g., `enUS`, `deDE`).
  activeLocale = GetLocale(),
  ---The current expansion level of the game, represented as a number.
  currentExpansion = GetExpansionLevel()
}

---?
backbone.getEnvironment = function ()
  print 'backbone.getEnvironment not implemented.'
end

---@param exception string The exception message to throw. Supports formatting placeholders.
---@param ... string Additional arguments to format the exception message.
---Throws a formatted exception with the specified message.
---* Formats the exception message if additional arguments are provided.
---* Raises an error with a stack trace at level 3 for better debugging.
backbone.throw = function (exception, ...)
  error(( ... and string.format (exception, ...)) or exception, 3)
end
