---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'plugin-api' --[[@as plugin]]

---@type listenableConstructor
local createListenableObject = repository.use 'listenable'

--[[~ Module: Channel Manager ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  This module manages communication channels within the framework. Channels are used 
  to broadcast messages to multiple listeners, providing a structured way for plugins 
  to communicate asynchronously. The module handles the reservation of channels, 
  registering listeners, and invoking them when necessary.

  Developer's notes:

  - Each channel must have a unique name to prevent conflicts.

  - Channels can be reserved as internal, meaning only the reserving context 
    can use them.
    
  - Listeners are registered to channels and invoked when messages are broadcasted.
  
  Dependencies: Listenable

]]

---@type table<string, channel>
local channels = {}

---
--- Reserves a new communication channel. If a channel with the same name already
--- exists, an error is thrown. The reserved channel can be asynchronous and
--- internal, limiting access to the reserving plugin.
---
---@param channel   string "The name of the channel being reserved."
---@param options   table  "Options for the channel (async, internal)."
---@param context?  plugin "The context of the plugin reserving the channel."
---
local reserveChannel = function(channel, options, context)
  options = options or {}

  xtype.validate {
    { 'channel:string', channel },
    { 'options.async:boolean?', options.async },
    { 'options.internal:boolean?', options.internal },
  }

  -- Throw an error if a channel with the same name has already been reserved.
  -- This ensures that channel names remain unique across the framework.

  if channels[channel] ~= nil then
    throw('Unable to reserve channel "%s" (non-unique name).', channel)
  end

  -- Create a new listenable object for the channel, allowing listeners to
  -- register and be invoked. The async and internal options are stored
  -- for future handling.

  channels[channel] = createListenableObject() --[[@as channel]]
  channels[channel].async = options.async
  channels[channel].internal = options.internal
  channels[channel].context = context
end

---
--- Registers a listener to a specified channel. If the channel is internal
--- and the context does not match the reserving plugin, an error is thrown.
---
---@param channel   string   "The name of the channel to register the listener to."
---@param listener  listener "The listener to register."
---@param context?  plugin   "The context of the plugin registering the listener."
---
local registerChannelListener = function(channel, listener, context)
  xtype.validate {
    { 'channel:string', channel },
    { 'listener:table', listener },
    { 'context:table?', context },
  }

  -- Throw an error if the channel does not exist, as listeners can only be
  -- registered to active channels.

  if channels[channel] == nil then
    throw('Failed to register listener to channel "%s" (unknown channel).', channel)
  end

  -- Prevent listeners from registering to internal channels unless they belong
  -- to the plugin that reserved the channel. This ensures channel integrity.

  if channels[channel].internal == true and channels[channel].context ~= context then
    throw('Failed to register listener to channel "%s" (internal channel).', channel)
  end

  -- Prepend the context identifier to the listener's identifier if the listener
  -- is being registered in the context of a plugin. This ensures listener uniqueness.

  if context ~= nil then
    listener.identifier = context.identifier .. '.' .. listener.identifier
  end

  channels[channel]:registerListener(listener)
end

---
--- Removes a listener from the specified channel. If the channel is internal,
--- the context must match the reserving plugin for the listener to be removed.
---
---@param channel    string "The name of the channel to remove the listener from."
---@param identifier string "The unique identifier of the listener to remove."
---@param context?   plugin "The context of the plugin removing the listener."
---
local removeChannelListener = function(channel, identifier, context)
  xtype.validate {
    { 'channel:string', channel },
    { 'identifier:string', identifier },
    { 'context:table?', context },
  }

  -- Throw an error if the channel does not exist, as listeners cannot be removed
  -- from inactive or non-existent channels.

  if channels[channel] == nil then
    throw('Failed to remove listener from channel "%s" (unknown channel).', channel)
  end

  -- Adjust the listener's identifier if a context is provided, ensuring the correct
  -- listener is removed in the context of a plugin.

  if context ~= nil then identifier = context.identifier .. '.' .. identifier end
  channels[channel]:removeListener(identifier)
end

---
--- Invokes all listeners on a specified channel, passing along any payload.
--- The listeners are executed asynchronously if the channel is marked as async.
--- Internal channels can only be invoked by the reserving plugin.
---
---@param channel   string    "The name of the channel to invoke listeners on."
---@param payload?  unknown[] "The payload to pass to the listeners."
---@param context?  plugin    "The context of the plugin invoking the listeners."
---
local invokeChannelListeners = function(channel, payload, context)
  xtype.validate {
    { 'channel:string', channel },
    { 'context:table?', context },
  }

  -- Throw an error if the channel does not exist, as listeners cannot be invoked
  -- on inactive or non-existent channels.

  if channels[channel] == nil then
    throw('Failed to invoke listeners on channel "%s" (unknown channel).', channel)
  end

  -- Throw an error if an attempt is made to invoke listeners on an internal channel
  -- by a plugin that does not own the channel.

  if channels[channel].context ~= context then
    throw('Failed to invoke listeners on channel "%s" (invalid context).', channel)
  end

  -- Invoke all listeners on the channel. If the channel is asynchronous, listeners
  -- will be executed asynchronously to avoid blocking the main thread.

  channels[channel]:invokeListeners(payload, { async = channels[channel].async })
end

---
--- Allows plugins to reserve communication channels by calling the reserveChannel function
--- with the plugin's context. This ensures that the reserved channel is associated
--- with the plugin for future communication.
---
plugin.reserveChannel = function(self, channel, options)
  reserveChannel(channel, options, self)
end

---
--- Allows plugins to register listeners to specific channels, ensuring that the
--- listeners are uniquely identified by the plugin's context.
---
plugin.registerChannelListener = function(self, channel, listener)
  registerChannelListener(channel, listener, self)
end

---
--- Allows plugins to remove their registered listeners from a channel, using
--- the plugin's context to ensure correct identification.
---
plugin.removeChannelListener = function(self, channel, identifier)
  removeChannelListener(channel, identifier, self)
end

---
--- Allows plugins to invoke listeners on a specified channel, passing along
--- any payload to the registered listeners.
---
plugin.invokeChannelListeners = function(self, channel, payload)
  invokeChannelListeners(channel, payload, self)
end
