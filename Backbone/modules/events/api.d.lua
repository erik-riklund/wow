---@meta

---
--- Defines the API for managing event listeners within plugins.
---
---@class EventsApi
---@field onLoad EventsApi.onLoad
---@field registerEventListener EventsApi.registerEventListener
---@field removeEventListener EventsApi.removeEventListener

---
--- Registers a callback to be executed when the plugin is loaded.
---
---@alias EventsApi.onLoad fun(self: Plugin, callback: function)

---
--- Registers an event listener for the specified event.
---
---@alias EventsApi.registerEventListener fun(self: Plugin, event: string, listener: Listener)

---
--- Removes the listener associated with the specified identifier from the specified event.
---
---@alias EventsApi.removeEventListener fun(self: Plugin, event: string, identifier: string)
