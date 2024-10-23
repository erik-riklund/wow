---@class Backbone
local context = select(2, ...)

--[[~ Module: Network ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---
--- Defines the API for managing network communication channels within plugins.
---
---@class NetworkApi
---
local api = {
  ---
  --- Creates a new communication channel.
  ---
  ---@param self Plugin
  ---@param name string
  ---@param options? ChannelOptions
  ---
  createChannel = function(self, name, options)
    backbone.createChannel(self, name, options)
  end,

  ---
  --- Invokes the registered listeners for the specified communication channel.
  ---
  ---@param self Plugin
  ---@param channel string
  ---@param arguments? unknown[]
  ---
  invokeChannelListeners = function(self, channel, arguments)
    backbone.invokeChannelListeners(self, channel, arguments) --
  end,

  ---
  --- Registers a new listener for the specified communication channel,
  --- allowing the listener to react to channel events.
  ---
  ---@param self Plugin
  ---@param channel string
  ---@param listener Listener
  ---
  registerChannelListener = function(self, channel, listener)
    backbone.registerChannelListener(self, channel, listener) --
  end,

  ---
  --- Removes the listener associated with the specified identifier from the communication channel.
  ---
  ---@param self Plugin
  ---@param channel string
  ---@param identifier string
  ---
  removeChannelListener = function(self, channel, identifier)
    backbone.removeChannelListener(self, channel, identifier) --
  end,
}

---
--- Integrate the network API into new plugins.
---
backbone.registerChannelListener(context.plugin, 'PLUGIN_ADDED', {
  identifier = 'networkApiIntegration',
  ---@param plugin Plugin
  callback = function(plugin) backbone.utilities.integrateTable(plugin, api) end,
})
