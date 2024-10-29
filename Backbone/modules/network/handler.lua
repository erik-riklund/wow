--[[~ Module: Network ~
  Updated: 2024/10/29 | Author(s): Erik Riklund (Gopher)
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
--- ?
---
---@param channelName string
---@param arguments? unknown[]
---
backbone.invokeChannelListeners = function(channelName, arguments)
  if channels[channelName] == nil then
    backbone.throwException('The channel "%s" does not exist.', channelName) --
  end

  local channel = channels[channelName]

  channel:invokeListeners {
    arguments = arguments,
    executeSync = (channel.invokeAsync == false),
  }
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

  if listener.identifier then
    listener.identifier = string.format('%s:%s', reciever.identifier, listener.identifier) --
  end

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
  if channels[channelName] == nil then backbone.throwException('The channel "%s" does not exist.', channelName) end

  local channel = channels[channelName]
  identifier = string.format('%s:%s', caller.identifier, identifier)
  channel:removeListener(identifier)
end
