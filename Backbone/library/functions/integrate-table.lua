
--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

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

---@param base table The target table to which the contents of the source table will be added.
---@param source table The table containing the data to merge into the base table.
---@param overwrite? boolean Determines whether existing keys in the base table can be overwritten (default: false)
---@return table base Returns a reference to the provided base table.
---Merges the contents of a source table into a base table,
---with optional overwrite protection for existing keys.
_G.integrateTable = function (base, source, overwrite)
  if type (base) ~= 'table' or type (source) ~= 'table' then
    error('Expected both `base` and `source` to be tables.', 3)
  end

  for key, value in pairs (source) do
    if base[key] ~= nil and overwrite ~= true then
      error('The base table already contains the key "'.. key ..'".', 3)
    end
    base[key] = value
  end

  return base
end
