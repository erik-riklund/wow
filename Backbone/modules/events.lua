---@class Backbone
local context = select(2, ...)

--[[~ Event handler (module) ~
  Updated: 2024/11/19 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local active_events = new 'Dictionary'

---
--- ?
---
context.frame:RegisterEvent 'ADDON_LOADED'

---
--- ?
---
context.frame:HookScript(
  'OnEvent',
  ---@param event EventName
  ---@param ... unknown
  function(_, event, ...)
    if event == 'ADDON_LOADED' then
    end
  end
)

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
events_api.registerEventListener = function(self, event, listener)
  print 'events_api.registerEventListener not implemented'
end

---
--- ?
---
---@param event EventName
---@param identifier string
---
events_api.removeEventListener = function(self, event, identifier)
  print 'events_api.removeEventListener not implemented'
end

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
