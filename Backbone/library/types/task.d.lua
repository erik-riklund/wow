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

---@class Task
---Represents a unit of work to be executed, either synchronously or asynchronously.
local task =
{
  ---@type string?
  ---A unique identifier for the task.
  identifier = nil,

  ---@type function
  ---The callback function to be executed when the task runs.
  callback = nil,

  ---@type Vector?
  ---Optional arguments to pass to the callback function when the task is executed.
  arguments = nil
}
