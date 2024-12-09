--[[~ Updated: 2024/12/09 | Author(s): Gopher ]]

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

local blocker = function()
  error ('Attempt to modify an immutable table.', 3)
end

---@param target table
---@return table
---Creates a read-only proxy for the provided table.
---
_G.createImmutableProxy = function(target)
  ---@param key string
  local retriever = function (_, key)
    if type (target[key]) ~= 'table' then return target[key] end

    return createImmutableProxy (target[key])
  end

  return setmetatable ({}, { __index = retriever, __newindex = blocker })
end
