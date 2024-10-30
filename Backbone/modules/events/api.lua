---@class Backbone
local context = select(2, ...)

--[[~ Module: Events ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---
--- Defines the API for managing event listeners within plugins.
---
---@class EventsApi
---
local api = {
  ---
  --- Registers a callback to be executed when the plugin is loaded.
  ---
  ---@param self Plugin
  ---@param callback function
  ---
  onLoad = function(self, callback)
    backbone.registerEventListener(self, 'ADDON_LOADED', { callback = callback }) --
  end,

  ---
  --- Registers an event listener for the specified event.
  ---
  ---@param self Plugin
  ---@param eventName WowEvent
  ---@param listener Listener
  ---
  registerEventListener = function(self, eventName, listener)
    backbone.registerEventListener(self, eventName, listener) --
  end,

  ---
  --- Removes the listener associated with the specified identifier from the specified event.
  ---
  ---@param self Plugin
  ---@param eventName WowEvent
  ---@param identifier string
  ---
  removeEventListener = function(self, eventName, identifier)
    backbone.removeEventListener(self, eventName, identifier) --
  end,
}

---
--- Integrates the events API into new plugins.
---
context.apis[#context.apis + 1] = function(plugin)
  backbone.utilities.integrateTable(plugin, api) --
end
