---@class Backbone
local context = select(2, ...)

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

local channels = new 'Dictionary'

---@param owner Plugin
---@param name string
---@param options? ChannelOptions
local createChannel = function (owner, name, options)
  options = options or {}

  local id = string.upper (name)
  if channels:hasEntry (id) then
    backbone.throw ('The channel "%s" already exists.', name)
  end

  local channel = new 'Listenable' --[[@as Channel]]
  integrateTable (channel, {
    owner = owner, async = options.async, internal = options.internal
  })

  channels:setEntry (id, channel)
end

---@param owner Plugin
---@param channelName string
---@param listener Listener
local registerListener = function (owner, channelName, listener)
  local channelId = string.upper (channelName)
  if not channels:hasEntry (channelId) then
    backbone.throw ('The channel "%s" does not exist.', channelName)
  end

  ---@type Channel
  local channel = channels:getEntry (channelId)
  if channel.internal and channel.owner ~= owner then
    backbone.throw ('The channel "%s" is protected.', channelName)
  end

  channel:registerListener (listener)
end

---@param caller Plugin
---@param channelName string
---@param listenerId string
local removeListener = function (caller, channelName, listenerId)
  local channelId = string.upper (channelName)
  if not channels:hasEntry (channelId) then
    backbone.throw ('The channel "%s" does not exist.', channelName)
  end

  ---@type Channel
  local channel = channels:getEntry (channelId)
  if channel.internal and channel.owner ~= caller then
    backbone.throw ('The channel "%s" is protected.', channelName)
  end

  channel:removeListener (listenerId)
end

---@param caller Plugin
---@param channelName string
---@param arguments? Vector
local invokeListeners = function (caller, channelName, arguments)
  local channelId = string.upper (channelName)
  if not channels:hasEntry (channelId) then
    backbone.throw ('The channel "%s" does not exist.', channelName)
  end

  ---@type Channel
  local channel = channels:getEntry (channelId)
  if channel.owner ~= caller then
    backbone.throw ('The channel "%s" may not be invoked by %s.', channelName, caller:getName())
  end

  channel:invokeListeners (arguments, channel.async)
end

--- PLUGIN API ---

---@class Plugin
local networkApi = context.pluginApi

---@param name string
---@param options? ChannelOptions
---Creates a new communication channel with the specified name and optional configuration.
networkApi.createChannel = function (self, name, options) createChannel (self, name, options) end

---@param channel string
---@param listener Listener
---Registers a listener to the specified channel.
networkApi.registerChannelListener = function (self, channel, listener)
  if listener.id then
    listener.id = string.format ('%s/%s', self.name, listener.id)
  end

  registerListener (self, channel, listener)
end

---@param channel string
---@param id string
---Removes a previously registered listener from the specified channel.
networkApi.removeChannelListener = function (self, channel, id)
  removeListener (self, channel, string.format ('%s/%s', self.name, id))
end

---@param channel string
---@param ... unknown
---Invokes all listeners registered to a specified channel with the provided arguments.
networkApi.invokeChannelListeners = function (self, channel, ...)
  invokeListeners (self, channel, (... and Vector {...}) or nil)
end

--- FRAMEWORK CHANNELS ---

context.plugin:createChannel 'PLUGIN_LOADED'
context.plugin:createChannel 'PLUGIN_READY'
