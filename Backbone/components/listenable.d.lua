---@meta

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
