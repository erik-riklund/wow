---@meta

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

---@class Listener
---Represents an object that listens to a `Listenable` object (events, channels, etc.).
local listener =
{
  ---@type string?
  ---A unique identifier for the listener. (optional)
  ---* If omitted, the listener will be anonymous (not eligible for targeted removal).
  id = nil,

  ---@type function
  ---The callback function to be invoked when the listener is triggered.
  callback = nil,

  ---@type boolean?
  ---Indicates whether the listener should persist after being invoked. (optional)
  ---* If true, the listener remains active; if false, it is automatically removed after one invocation.
  ---* Defaults to true if not specified.
  persistent = nil
}
