---@meta

---
--- Defines the options for configuring a communication channel, including whether 
--- it is internal and if listeners should be invoked asynchronously.
---
---@class ChannelOptions
---@field invokeAsync? boolean

---
--- Represents a communication channel that supports listener registration, invocation,
--- and additional options like asynchronous execution and internal-only access.
---
---@class Channel : Listenable, ChannelOptions
---@field owner Plugin
