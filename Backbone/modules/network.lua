---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'plugin-api' --[[@as plugin]]

---@type listenableConstructor
local createListenableObject = repository.use 'listenable'

--[[~ Module: Channel Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/25

  This module manages communication channels within the framework. It allows
  for reserving, registering listeners, removing listeners, and invoking
  listeners on specific channels. The module supports asynchronous execution 
  and internal channels tied to specific plugin contexts.

  Features:

  - Reserve communication channels with unique names.
  - Register listeners for specific channels.
  - Remove listeners from channels based on unique identifiers.
  - Invoke listeners on channels with optional payload support.
  - Support asynchronous and internal (plugin-specific) channels.

  Dependencies: Listenable (component)

]]

---@type table<string, channel>
local channels = {}

---
--- Reserves a communication channel with specified options. The channel is registered
--- only if the name is unique.
---
---@param channel   string "The name of the channel to reserve."
---@param options   table  "Options for the channel, including async and internal flags."
---@param context?  plugin "The plugin context in which this channel is reserved."
---
local reserveChannel = function(channel, options, context)
  options = options or {}

  xtype.validate {
    { 'channel:string', channel },
    { 'options.async:boolean?', options.async },
    { 'options.internal:boolean?', options.internal },
  }

  if channels[channel] ~= nil then
    throw('Unable to reserve channel "%s" (non-unique name).', channel)
  end

  channels[channel] = createListenableObject() --[[@as channel]]
  channels[channel].async = options.async
  channels[channel].internal = options.internal
  channels[channel].context = context
end

---
--- Registers a listener to a specific channel. Listeners can only be attached to
--- channels that are already reserved. If the channel is internal, it must belong to
--- the same plugin context.
---
---@param channel   string   "The name of the channel to register the listener to."
---@param listener  listener "The listener object that will be attached to the channel."
---@param context?  plugin   "The plugin context for the listener registration."
---
local registerChannelListener = function(channel, listener, context)
  xtype.validate {
    { 'channel:string', channel },
    { 'listener:table', listener },
    { 'context:table?', context },
  }

  if channels[channel] == nil then
    throw('Failed to register listener to channel "%s" (unknown channel).', channel)
  end

  if channels[channel].internal == true and channels[channel].context ~= context then
    throw('Failed to register listener to channel "%s" (internal channel).', channel)
  end

  if context ~= nil then
    listener.identifier = context.identifier .. '.' .. listener.identifier
  end

  channels[channel]:registerListener(listener)
end

---
--- Removes a listener from a specific channel. If the channel is internal, the context
--- must match. The listener is identified by a unique identifier.
---
---@param channel    string "The name of the channel to remove the listener from."
---@param identifier string "The unique identifier of the listener to remove."
---@param context?   plugin "The plugin context for listener removal."
---
local removeChannelListener = function(channel, identifier, context)
  xtype.validate {
    { 'channel:string', channel },
    { 'identifier:string', identifier },
    { 'context:table?', context },
  }

  if channels[channel] == nil then
    throw('Failed to remove listener from channel "%s" (unknown channel).', channel)
  end

  if context ~= nil then identifier = context.identifier .. '.' .. identifier end
  channels[channel]:removeListener(identifier)
end

---
--- Invokes all listeners on a specific channel, optionally passing a payload.
--- If the channel is internal, the context must match. The invocation can be
--- performed asynchronously based on the channel configuration.
---
---@param channel   string    "The name of the channel to invoke the listeners on."
---@param payload?  unknown[] "Optional data to pass to the listeners."
---@param context?  plugin    "The plugin context for listener invocation."
---
local invokeChannelListeners = function(channel, payload, context)
  xtype.validate { { 'channel:string', channel }, { 'context:table?', context } }

  if channels[channel] == nil then
    throw('Failed to invoke listeners on channel "%s" (unknown channel).', channel)
  end

  if channels[channel].context ~= context then
    throw('Failed to invoke listeners on channel "%s" (invalid context).', channel)
  end

  channels[channel]:invokeListeners(payload, { async = channels[channel].async })
end

-- methods for the plugin API:

plugin.reserveChannel = function(self, channel, options)
  reserveChannel(channel, options, self)
end

plugin.registerChannelListener = function(self, channel, listener)
  registerChannelListener(channel, listener, self)
end

plugin.removeChannelListener = function(self, channel, identifier)
  removeChannelListener(channel, identifier, self)
end

plugin.invokeChannelListeners = function(self, channel, payload)
  invokeChannelListeners(channel, payload, self)
end
