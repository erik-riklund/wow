---@meta

--[[~ Updated: 2024/12/05 | Author(s): Gopher ]]

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

---@class Task
local task =
{
  ---@type string?
  ---A unique identifier for the task. (optional)
  ---* If omitted, the task will be anonymous (not eligible for targeted removal).
  ---
  id = nil,
  
  ---@type function
  ---The callback function to be invoked when the task is executed.
  ---
  callback = nil,

  ---@type Vector?
  ---A list of arguments to be passed to the callback function (optional).
  ---
  arguments = nil
}