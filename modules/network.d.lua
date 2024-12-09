---@meta

--[[~ Updated: 2024/12/06 | Author(s): Gopher ]]

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

---@class Backbone.ChannelOptions
---Represents the options for a channel.
---@field internal boolean? Specifies whether the channel is internal or not.
---@field executeAsync boolean? Specifies whether listeners on this channel are executed in the background (asynchronously) or immediately.

---@class Backbone.Channel : Listenable, Backbone.ChannelOptions
---Represents a channel for communication between addons or plugins.
---@field name string The name of the channel.
---@field owner Backbone.Plugin The owner of the channel.
