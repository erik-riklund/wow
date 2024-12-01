
--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

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

---@param target string The string to be split.
---@param separator string The delimiter used to separate the string.
---@param pieces? number The maximum number of splits to perform. If not provided, all possible splits are performed.
---@return Vector components A `Vector` object containing the split components of the string.
---Splits a string into parts based on a given separator, and returns the result as a `Vector` object.
_G.split = function (target, separator, pieces)
  local components = Vector { string.split(separator, target, pieces) }
  components:forEach(function (_, element) return string.trim(element) end)

  return components
end
