---@class Backbone
local context = select(2, ...)

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

local channels = new 'Dictionary'

---@param owner Plugin
---@param name string
---@param options? ChannelOptions
---
local createChannel = function (owner, name, options)
  print 'createChannel not implemented'
end

---@param caller Plugin
---@param channel string
---@param ... unknown
---
local invokeChannel = function (caller, channel, ...)
  print 'invokeChannel not implemented'
end

---@param caller Plugin
---@param channel string
---@param listener Listener
---
local registerListener = function (caller, channel, listener)
  print 'registerListener not implemented'
end

---@param caller Plugin
---@param channel string
---@param listenerId string
---
local removeListener = function (caller, channel, listenerId)
  print 'removeListener not implemented'
end

-- PLUGIN API --

---@class Plugin
local networkAPI = context.pluginApi

---@param name string
---@param options? ChannelOptions
---Creates a new channel with the specified name and options.
---
networkAPI.createChannel = function (self, name, options)
  createChannel (self, name, options)
end

---@param channelName string
---@param ... unknown
---Invokes the specified channel. Provided arguments are passed to the listeners (optional).
---
networkAPI.invokeChannel = function (self, channelName, ...)
  invokeChannel (self, channelName, ...)
end

---@param channelName string
---@param listener Listener
---Registers a callback function to be executed when the specified channel is invoked.
---
networkAPI.registerChannelListener = function (self, channelName, listener)
  registerListener (self, channelName, listener)
end

---@param channelName string
---@param listenerId string
---Removes the specified listener from the channel.
---
networkAPI.removeChannelListener = function (self, channelName, listenerId)
  removeListener (self, channelName, listenerId)
end
