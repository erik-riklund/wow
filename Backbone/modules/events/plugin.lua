--[[~ Module: Events ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

local _, context = ...

---@type EventsApi
local api = {
  --
  onLoad = function(self, callback)
    backbone.registerEventListener(self, 'ADDON_LOADED', { callback = callback })
  end,
  --
  registerEventListener = function(self, event, listener)
    backbone.registerEventListener(self, event, listener)
  end,
  --
  removeEventListener = function(self, event, identifier)
    backbone.removeEventListener(self, event, identifier)
  end,
}

---
--- Integrate the events API into new plugins.
---
backbone.registerChannelListener(context.plugin, 'PLUGIN_ADDED', {
  identifier = 'eventsApiIntegration',
  ---@param plugin Plugin
  callback = function(plugin) backbone.utilities.integrateTable(plugin, api) end,
})
