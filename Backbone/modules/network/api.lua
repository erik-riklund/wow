---@class Backbone
local context = select(2, ...)

--[[~ Network ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---
--- Defines the API for managing network communication channels within plugins.
---
---@class NetworkApi
---
local api = {
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
--- Integrates the network API into new plugins.
---
context.apis[#context.apis + 1] = function(plugin)
  backbone.utilities.integrateTable(plugin, api) --
end
