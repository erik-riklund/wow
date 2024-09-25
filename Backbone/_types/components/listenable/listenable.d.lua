---@meta

---
--- A base class for any object that can manage and notify listeners.
--- Used to allow plugins or other components to react to specific events or actions.
--- Developers can use this to register, invoke, or remove event listeners.
---
---@class listenable
---
---@field listeners?          listener[]                         -- Stores the currently registered listeners. Optional.
---@field invokeListeners     listenable.invokeListeners         -- Triggers all listeners, passing in any relevant arguments.
---@field registerListener    listenable.registerListener        -- Adds a new listener to the object.
---@field removeListener      listenable.removeListener          -- Unregisters a listener by its identifier, stopping further invocations.
---

---
--- Triggers all the listeners registered to the object.
--- Developers can use this to notify listeners, either synchronously or asynchronously.
---
---@alias listenable.invokeListeners
---| fun(self: listenable, arguments?: unknown[], options?: { async: boolean })
---

---
--- Registers a listener to be notified when specific events occur.
--- Developers should use this to add custom event handlers or callbacks.
---
---@alias listenable.registerListener
---| fun(self: listenable, listener: listener)
---

---
--- Removes a previously registered listener using its unique identifier.
--- Developers can use this to clean up or stop notifications for a listener.
---
---@alias listenable.removeListener
---| fun(self: listenable, identifier: string)
---
