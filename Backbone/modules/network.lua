local addon, repository = ...

--[[~ Module: Network ~
  Created: 2024/10/03
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

---@type hashmap<string, Channel>
local channels = {}

---
--- ?
---
---@param name string
---@param options? createChannel.options
---@param context Plugin
---
local createChannel = function(name, options, context)
  print 'createChannel is not implemented'
end

---
--- ?
---
---@param channel string
---@param listener Listener
---@param context Plugin
---
local registerChannelListener = function(channel, listener, context)
  print 'registerChannelListener is not implemented'
end

---
--- ?
---
---@param channel string
---@param identifier string
---@param context Plugin
---
local removeChannelListener = function(channel, identifier, context)
  print 'removeChannelListener is not implemented'
end

---
--- ?
---
---@param channel string
---@param payload? unknown
---@param context Plugin
---
local invokeChannelListeners = function(channel, payload, context)
  print 'invokeChannelListeners is not implemented'
end

-- Implements the network-related methods in the plugin API.

---@type Plugin
local api = repository.pluginApi

api.createChannel = function(self, name, options)
  createChannel(name, options, self)
end

api.registerChannelListener = function(self, channel, listener)
  registerChannelListener(channel, listener, self)
end

api.removeChannelListener = function(self, channel, identifier)
  removeChannelListener(channel, identifier, self)
end

api.invokeChannelListeners = function(self, channel, payload)
  invokeChannelListeners(channel, payload, self)
end
