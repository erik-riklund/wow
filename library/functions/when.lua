--[[~ Updated: 2024/12/08 | Author(s): Gopher ]]

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

---@generic T
---@param condition boolean
---@param onTrue `T`
---@param onFalse T
---@return T
--- Provides a hybrid ternary operator. The return values must be of the same type.
---
--- Explanation of the problem using built-in and-or syntax:
--- ```lua
--- local value = (someValue == nil and variableWithValueFalse) or variableWithValueTrue
--- -- even if `someValue` is nil, `value` will always be assigned `variableWithValueTrue`.
--- ```
---
_G.when = function (condition, onTrue, onFalse)
  if condition == true then return onTrue else return onFalse end
end
