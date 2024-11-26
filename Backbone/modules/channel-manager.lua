---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/21 | Author(s): Gopher ]]

---
--- ?
---
local channels = new 'Dictionary'

---
--- ?
---
local getNormalizedChannelName =
  function (name) return string.upper (name) end

---
--- ?
---
---@param name string
---@param plugin Plugin
---@return Channel
---
local getChannel = function (name, plugin)
  local normalized_name = getNormalizedChannelName (name)

  if not channels:hasEntry (normalized_name) then
    new ('Error', 'Unknown channel "%s" (%s)', normalized_name, plugin:getIdentifier ())
  end

  return channels:getEntry (normalized_name)
end

---
---@class Plugin
---
local network_api = {}

---
--- ?
---
---@param name string
---@param options? ChannelOptions
---
network_api.createChannel = function (self, name, options)
  local normalized_name = getNormalizedChannelName (name)
  
  if channels:hasEntry (normalized_name) then
    new ('Error', 'Channel creation failed, duplicate name "%s" (%s)',
      normalized_name, self:getIdentifier ())
  end

  channels:setEntry (normalized_name, new ('Channel', self, normalized_name, options))
end

---
--- ?
---
---@param channel_name string
---@param listener Listener
---
network_api.registerChannelListener = function(self, channel_name, listener)
  local channel = getChannel(channel_name, self)
  
  if channel.internal == true and channel.owner:getIdentifier() ~= self:getIdentifier() then
    new('Error', 'Cannot register listeners on internal channel "%s" (%s)', channel.name, self:getIdentifier())
  end

  if listener.identifier then
    listener.identifier = self:getIdentifier() .. '/' .. listener.identifier
  end

  channel:registerListener(listener)
end

---
--- ?
---
---@param channel_name string
---@param identifier string
---
network_api.removeChannelListener = function(self, channel_name, identifier)
  local channel = getChannel(channel_name, self)
  
  channel:removeListener(self:getIdentifier() .. '/' .. identifier)
end

---
--- ?
---
---@param channel_name string
---@param payload? unknown
---
network_api.invokeChannelListeners = function(self, channel_name, payload)
  local channel = getChannel(channel_name, self)

  if channel.owner:getIdentifier() ~= self:getIdentifier() then
    new('Error', 'Cannot invoke listeners on channel "%s" (%s)', channel.name, self:getIdentifier())
  end
  
  channel:invokeListeners(new('Vector', { payload }), channel.async)
end

---
--- ?
---
context.registerPluginExtension(
  function(plugin)
    plugin.createChannel = network_api.createChannel
    plugin.invokeChannelListeners = network_api.invokeChannelListeners

    plugin.registerChannelListener = network_api.registerChannelListener
    plugin.removeChannelListener = network_api.removeChannelListener
  end
)
