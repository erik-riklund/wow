--[[~ Module: Network ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@type hashmap<string, Channel>
local channels = {}

---
--- ?
---
---@param name string
---@param options { internal?: boolean, async?: boolean }
---@param owner? Plugin
---
local createChannel = function(name, options, owner)
  if channels[name] ~= nil then
    backbone.throwError('Failed to create channel "%s" (non-unique name).', name)
  end

  if type(options) ~= 'table' then options = {} end

  local channel = backbone.createListenableComponent() --[[@as Channel]]
  channel.async = (options.async ~= false and true) or false
  channel.internal = (options.internal == true)
  channel.owner = owner

  channels[name] = channel
end

---
--- ?
---
local invokeListeners = function(channel, arguments, caller) end

---
--- ?
---
---@param channel string
---@param identifier string
---@param callback function
---@param options? { owner?: Plugin, persistent?: boolean }
---
local registerListener = function(channel, identifier, callback, options)
  if type(options) ~= 'table' then options = {} end

  --
end

---
--- ?
---
local removeListener = function(channel, identifier, owner) end

--
-- ?
--
createChannel('PLUGIN_ADDED', { internal = true, async = false })

---
--- ?
---
---@type NetworkApi
---
local api = {
  createChannel = function(self, name, options)
    createChannel(name, options, self or {}) --
  end,
  invokeChannelListeners = function(self, channel, arguments)
    invokeListeners(channel, arguments, self or {}) --
  end,
  registerChannelListener = function(self, channel, identifier, callback, persistent)
    registerListener(channel, identifier, callback, { owner = self or {}, persistent = persistent })
  end,
  removeChannelListener = function(self, channel, identifier)
    removeListener(channel, identifier, self or {}) --
  end,
}

--
-- ?
--
registerListener(
  'PLUGIN_ADDED',
  'NETWORK_API_INTEGRATION',
  ---@param plugin Plugin
  function(plugin) utilities.integrateTable(plugin, api) end
)
