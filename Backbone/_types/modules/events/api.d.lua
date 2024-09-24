--- @meta

---
--- The `events.api` class provides methods for managing event listeners in the plugin.
--- It includes functionality for registering one-time initialization callbacks,
--- registering event listeners, and removing event listeners.
---
--- @class events.api
---
--- @field onInitialize           events.api.onInitialize
--- @field registerEventListener  events.api.registerEventListener
--- @field removeEventListener    events.api.removeEventListener

---
--- Registers a one-time initialization callback, triggered when the `ADDON_LOADED` event fires.
---
---@alias events.api.onInitialize
---| fun(self: plugin, identifier: string, callback: function)
---

---
--- Registers a listener for a specified event, appending the plugin identifier to the listener identifier.
---
---@alias events.api.registerEventListener
---| fun(self: plugin, event: string, listener: listener)
---

---
--- Removes a listener from a specified event, using the plugin identifier as a prefix.
---
---@alias events.api.removeEventListener
---| fun(self: plugin, event: string, identifier: string)
---
