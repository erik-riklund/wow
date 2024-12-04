
--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

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

---@param target table
---@param parents? string
---@param result? table
---Flattens a table with nested tables into a single table, using a
---nested key scheme to represent the original table's structure.
_G.flattenTable = function (target, parents, result)
  if type (target) ~= 'table' then
    error('Expected a table for argument #1 (target).', 3)
  end

  result = (type (result) == 'table' and result) or {}
  for key, value in pairs (target) do
    local modified_key = string.gsub(key, '[$]', '')
    local result_key = (parents and string.format ('%s/%s', parents, modified_key)) or modified_key
    
    if type (value) == 'table' and (string.sub (key, 1, 1) ~= '$') then
      flattenTable (value, result_key, result) else result[result_key] = value
    end
  end

  return result
end
