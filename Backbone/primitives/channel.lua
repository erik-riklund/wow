---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/21 | Author(s): Erik Riklund (Gopher) ]]

---
--- ?
---
---@param owner Plugin
---@param name string
---@param options? ChannelOptions
---
Channel = function(owner, name, options)
  local channel = new 'Listenable' --[[@as Channel]]

  channel.owner = owner
  if type(options) == 'table' then
    channel.async = (options.async ~= false)
    channel.internal = (options.internal ~= false)
  end

  return channel
end
