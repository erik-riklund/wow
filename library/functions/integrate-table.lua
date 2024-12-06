
--[[~ Updated: 2024/12/02 | Author(s): Gopher ]]

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

---@param base table
---@param source table
---@param mode? 'skip'|'replace'|'strict'
---Integrates the source table into the base table.
---* `strict` (default): Throws an error if the key already exists in the base table.
---* `skip`: Does not overwrite the key if it already exists in the base table.
---* `replace`: Overwrites the key if it already exists in the base table.
_G.integrateTable = function (base, source, mode)
  mode = mode or 'strict'

  for key, value in pairs (source) do
    if mode == 'replace' or base[key] == nil then
      base[key] = value
    elseif mode == 'strict' then
      backbone.throw ('The key "%s" already exists in the base table.', key)
    end
  end

  return base
end

---@param base table
---@param sources table
---@param mode? 'skip'|'replace'|'strict'
---
_G.integrateTables = function (base, sources, mode)
  Vector (sources):forEach (
    function (index, source)
      integrateTable (base, source, mode)
    end
  )

  return base
end
