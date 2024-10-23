--[[~ Module: Network ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---@class Backbone
local context = select(2, ...)

---@type NetworkApi
local api = {
  --
  createChannel = function(self, name, options)
    backbone.createChannel(self, name, options) --
  end,
  --
  invokeChannelListeners = function(self, channel, arguments)
    backbone.invokeChannelListeners(self, channel, arguments) --
  end,
  --
  registerChannelListener = function(self, channel, listener)
    backbone.registerChannelListener(self, channel, listener) --
  end,
  --
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
