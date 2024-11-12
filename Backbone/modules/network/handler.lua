--[[~ Network ~
  Updated: 2024/11/12 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Channel>
local channels = {}

---
--- Creates a new channel object with listenable capabilities,
--- integrating it with the provided options.
---
---@param options ChannelOptions
---@return Channel
---
local createChannelObject = function(options)
  local listenable = backbone.components.createListenable()
  return backbone.utilities.integrateTable(listenable, options)
end

---
--- Creates a new channel with the specified name and options.
--- Throws an exception if the channel already exists.
---
---@param name string
---@param options? ChannelOptions
---
backbone.createChannel = function(name, options)
  if channels[name] ~= nil then
    backbone.throwException('The channel "%s" already exists.', name) --
  end

  channels[name] = createChannelObject(options or {})
end

---
--- Invokes all listeners of the specified channel, passing any arguments provided.
--- Throws an exception if the channel doesn't exist.
---
---@param channelName string
---@param ... unknown
---
backbone.invokeChannelListeners = function(channelName, ...)
  if channels[channelName] == nil then
    backbone.throwException('The channel "%s" does not exist.', channelName) --
  end

  local channel = channels[channelName]

  channel:invokeListeners {
    arguments = { ... },
    executeSync = (channel.invokeAsync == false),
  }
end

---
--- Registers a listener to a specified channel for the given receiver.
--- Throws an exception if the channel doesn't exist.
---
---@param reciever Plugin
---@param channelName string
---@param listener Listener
---
backbone.registerChannelListener = function(reciever, channelName, listener)
  if channels[channelName] == nil then
    backbone.throwException('The channel "%s" does not exist.', channelName) --
  end

  local channel = channels[channelName]

  if listener.identifier then
    listener.identifier = string.format('%s:%s', reciever.identifier, listener.identifier) --
  end

  channel:registerListener(listener)
end

---
--- Removes a listener from a specified channel by its identifier for a given caller.
--- Throws an exception if the channel doesn't exist.
---
---@param caller Plugin
---@param channelName string
---@param identifier string
---
backbone.removeChannelListener = function(caller, channelName, identifier)
  if channels[channelName] == nil then backbone.throwException('The channel "%s" does not exist.', channelName) end

  local channel = channels[channelName]
  identifier = string.format('%s:%s', caller.identifier, identifier)
  channel:removeListener(identifier)
end
