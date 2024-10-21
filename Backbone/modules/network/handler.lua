--[[~ Module: Network ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Channel>
local channels = {}

---
--- ?
---
---@param options ChannelOptions
---@return Channel
---
local createChannelObject = function(options)
  local listenable = backbone.components.createListenable()
  return backbone.utilities.integrateTable(listenable, options)
end

---
--- ?
---
---@param owner Plugin
---@param name string
---@param options? ChannelOptions
---
backbone.createChannel = function(owner, name, options)
  if channels[name] ~= nil then
    backbone.throwException('The channel "%s" already exists.', name) --
  end

  channels[name] = createChannelObject(options or {})
  channels[name].owner = owner
end

---
--- ?
---
---@param caller Plugin
---@param channelName string
---@param arguments? unknown[]
---
backbone.invokeChannelListeners = function(caller, channelName, arguments)
  if channels[channelName] == nil then
    backbone.throwException('The channel "%s" does not exist.', channelName) --
  end

  local channel = channels[channelName]
  if channel.isInternal == true and channel.owner ~= caller then
    backbone.throwException('Cannot invoke protected channel "%s" (%s).', channelName, caller.identifier)
    return -- stops execution in production mode.
  end

  channel:invokeListeners { arguments = arguments, executeSync = (channel.invokeAsync == false) }
end

---
--- ?
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
  if channel.isInternal == true and channel.owner ~= reciever then
    backbone.throwException('Cannot listen to protected channel "%s" (%s).', channelName, reciever.identifier)
    return -- stops execution in production mode.
  end

  listener.identifier = string.format('%s:%s', reciever.identifier, listener.identifier)
  channel:registerListener(listener)
end

---
--- ?
---
---@param caller Plugin
---@param channelName string
---@param identifier string
---
backbone.removeChannelListener = function(caller, channelName, identifier)
  if channels[channelName] == nil then
    backbone.throwException('The channel "%s" does not exist.', channelName) --
  end

  local channel = channels[channelName]
  if channel.isInternal ~= true or channel.owner == caller then
    identifier = string.format('%s:%s', caller.identifier, identifier)
    channel:removeListener(identifier)
  end
end
