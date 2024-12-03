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

---@class ChannelOptions
local options = {}

---@type boolean?
---Determines whether channel access is restricted to the current plugin.
options.internal = nil

---@type boolean?
---Indicates whether the channel is invoked asynchronously.
---* Defaults to `true` if not specified.
options.async = nil
