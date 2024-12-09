---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/04 | Author(s): Gopher ]]

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

---Triggers a garbage collection pass whenever the player enters the world.
context.plugin:registerEventListener(
  'PLAYER_ENTERING_WORLD', {
    identifier = 'GARBAGE:PLAYER_ENTERING_WORLD',
    callback = function() collectgarbage 'collect' end
  }
)

---Triggers a garbage collection pass if the player switches to AFK status.
context.plugin:registerEventListener(
  'PLAYER_FLAGS_CHANGED', {
    identifier = 'GARBAGE:PLAYER_FLAGS_CHANGED',
    callback = function (unit)
      if unit == 'player' and UnitIsAFK 'player' then collectgarbage 'collect' end
    end
  }
)

---Triggers a garbage collection pass if the player enters a vehicle or taxi.
context.plugin:registerEventListener(
  'UNIT_ENTERED_VEHICLE', {
    identifier = 'GARBAGE:UNIT_ENTERED_VEHICLE',
    callback = function (unit)
      if unit == 'player' and UnitOnTaxi 'player' then collectgarbage 'collect' end
    end
  }
)
