
--[[~ Updated: 2024/12/03 | Author(s): Gopher ]]

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
---@param steps table
---@param mode? 'exit'|'build'
---@return table?
---Traverses a table by following the provided steps and returns the result.
---* In build mode, missing steps will be created. In exit mode, missing steps will return `nil`.
---* If any step is a non-table value, the function will return `nil`.
_G.traverseTable = function (target, steps, mode)
  mode = mode or 'exit'

  if type (target) ~= 'table' then
    error('Expected a table for argument #1 (target).', 3)
  end
  if type (steps) ~= 'table' then
    error('Expected a table for argument #2 (steps).', 3)
  end
  if mode ~= 'exit' and mode ~= 'build' then
    error('Expected "exit" or "build" for argument #3 (mode).', 3)
  end

  local result = target
  for _, step in ipairs (steps) do
    if result[step] == nil  then
      if mode == 'exit' then return nil else result[step] = {} end
    end

    if type (result[step]) ~= 'table' then return nil end
    
    result = result[step] --[[@as table]]
  end

  return result
end
