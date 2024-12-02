
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

---@generic T
---@param objectType `T`
---@return T?
---Creates a new instance of the specified object type by dynamically
---calling the constructor for the given object type.
---* Throws an error if the constructor is not a globally accessible function.
_G.new = function (objectType)
  if type (_G[objectType]) ~= 'function' then
    error ('Object creation failed, invalid constructor for ' .. objectType, 3)
  end

  return _G[objectType]() -- returns a new instance of the specified type.
end
