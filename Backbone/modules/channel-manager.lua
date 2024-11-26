---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/21 | Author(s): Gopher ]]

local channels = new 'Dictionary'

---Converts a channel name to its normalized form.
---* Normalization is performed by converting the name to uppercase.
local getNormalizedChannelName = function (name) return string.upper (name) end

---@param name string
---@param plugin Plugin
---@return Channel
---Retrieves an existing channel by its name.
---* Throws an error if the channel does not exist.
local getChannel = function (name, plugin)
  local normalized_name = getNormalizedChannelName (name)
  if not channels:hasEntry (normalized_name) then
    new ('Error', 'Unknown channel "%s" (%s)', normalized_name, plugin:getIdentifier ())
  end
  return channels:getEntry (normalized_name)
end

---@class Plugin
local network_api = {}

---@param name string
---@param options? ChannelOptions
---Creates a new channel with the given name and options.
---* Throws an error if a channel with the same name already exists.
network_api.createChannel = function (self, name, options)
  local normalized_name = getNormalizedChannelName (name)
  if channels:hasEntry (normalized_name) then
    new ('Error', 'Channel creation failed, duplicate name "%s" (%s)', normalized_name, self:getIdentifier ())
  end
  channels:setEntry (normalized_name, new ('Channel', self, normalized_name, options))
end

---@param channel_name string
---@param listener Listener
---Registers a listener to a specific channel.
---* Throws an error if the channel is internal and owned by a different plugin.
network_api.registerChannelListener = function (self, channel_name, listener)
  local channel = getChannel (channel_name, self)
  if channel.internal == true and channel.owner:getIdentifier () ~= self:getIdentifier () then
    new ('Error', 'Cannot register listeners on internal channel "%s" (%s)', channel.name, self:getIdentifier ())
  end
  if listener.identifier then listener.identifier = self:getIdentifier () .. '/' .. listener.identifier end
  channel:registerListener (listener)
end

---@param channel_name string
---@param identifier string
---Removes a listener from a specific channel using its identifier.
network_api.removeChannelListener = function (self, channel_name, identifier)
  local channel = getChannel (channel_name, self)  
  channel:removeListener (self:getIdentifier () .. '/' .. identifier)
end

---@param channel_name string
---@param payload? unknown
---Invokes all listeners on a specific channel with an optional payload.
---* Throws an error if the channel is owned by a different plugin.
network_api.invokeChannelListeners = function (self, channel_name, payload)
  local channel = getChannel (channel_name, self)
  if channel.owner:getIdentifier () ~= self:getIdentifier () then
    new ('Error', 'Cannot invoke listeners on channel "%s" (%s)', channel.name, self:getIdentifier ())
  end
  channel:invokeListeners (new ('Vector', { payload }), channel.async)
end

---Extends the plugin with network API functionalities for managing channels.
context.registerPluginExtension(
  function (plugin)
    plugin.createChannel = network_api.createChannel
    plugin.invokeChannelListeners = network_api.invokeChannelListeners
    plugin.registerChannelListener = network_api.registerChannelListener
    plugin.removeChannelListener = network_api.removeChannelListener
  end
)
