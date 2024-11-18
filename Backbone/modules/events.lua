---@class Backbone
local context = select(2, ...)

--[[~ Event handler (module) ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local active_events = new 'Dictionary'

---
---@class Plugin
---
local events_api = {}

---
--- ?
---
---@param callback function
---
events_api.onLoad = function(self, callback)
  self:registerEventListener(
    'ADDON_LOADED',
    { callback = callback, persistent = false }
  )
end

---
--- ?
---
---@param event EventName
---@param listener Listener
---
events_api.registerEventListener = function(self, event, listener) end

---
--- ?
---
---@param event EventName
---@param identifier string
---
events_api.removeEventListener = function(self, event, identifier) end

---
--- ?
---
context.registerPluginExtension(
  function(plugin)
    plugin.onLoad = events_api.onLoad
    plugin.registerEventListener = events_api.registerEventListener
    plugin.removeEventListener = events_api.removeEventListener
  end --
)
