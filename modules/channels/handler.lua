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

local channels = new 'Dictionary'

---@param owner Plugin
---@param name string
---@param options ChannelOptions
---
local createChannel = function (owner, name, options) end

-- PLUGIN API --

---@class Plugin
local networkAPI = context.pluginApi

---@param name string
---@param options? ChannelOptions
---?
---
networkAPI.createChannel = function (self, name, options) end

---@param channelName string
---@param listener Listener
---?
---
networkAPI.registerChannelListener = function (self, channelName, listener) end

---@param channelName string
---@param listenerId string
---?
---
networkAPI.removeChannelListener = function (self, channelName, listenerId) end

---@param channelName string
---@param ... unknown
---?
---
networkAPI.invokeChannelListeners = function (self, channelName, ...) end
