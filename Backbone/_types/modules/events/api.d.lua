--- @meta

---
--- The `events.api` class provides methods for managing event listeners in the plugin. 
--- It includes functionality for registering one-time initialization callbacks, 
--- registering event listeners, and removing event listeners.
---
--- @class events.api
--- 
--- @field onInitialize?          fun(self: plugin, identifier: string, callback: function) "Registers a one-time initialization callback, triggered when the `ADDON_LOADED` event fires."
--- @field registerEventListener? fun(self: plugin, event: string, listener: listener) "Registers a listener for a specified event, appending the plugin identifier to the listener identifier."
--- @field removeEventListener?   fun(self: plugin, event: string, identifier: string) "Removes a listener from a specified event, using the plugin identifier as a prefix."

