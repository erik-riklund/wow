
--[[~ Updated: 2024/11/21 | Author(s): Gopher ]]

---@param owner Plugin The plugin that owns the channel.
---@param name string The name of the channel.
---@param options? ChannelOptions Optional settings for the channel.
---@return Channel channel A new channel object.
---Creates a new communication channel for plugins.
---* Channels can be used to manage and notify listeners with optional configurations.
Channel = function(owner, name, options)
  local channel = new 'Listenable' --[[@as Channel]]

  channel.name = name
  channel.owner = owner
  
  if type(options) == 'table' then
    channel.async = (options.async ~= false)
    channel.internal = (options.internal ~= false)
  end

  return channel
end
