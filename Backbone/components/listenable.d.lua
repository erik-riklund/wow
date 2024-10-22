---@meta

---
--- Represents an object that manages a list of listeners,
--- allowing them to be invoked, registered, or removed.
---
---@class Listenable
---@field listeners Listener[]
---@field invokeListeners fun(self: Listenable, options: Listenable.invokeListeners.options)
---@field registerListener fun(self: Listenable, listener: Listener)
---@field removeListener fun(self: Listenable, identifier: string)

---
--- Options for invoking listeners, including arguments to pass
--- and whether to execute synchronously.
---
---@class Listenable.invokeListeners.options
---@field arguments? unknown[]
---@field executeSync? boolean

---
--- Represents an individual listener with a callback function.
--- Each listener may also have a unique identifier and a persistence flag.
---
---@class Listener
---@field callback function
---@field identifier? string
---@field persistent? boolean
