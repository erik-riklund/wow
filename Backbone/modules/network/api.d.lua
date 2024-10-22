---@meta

---
--- Defines the API for managing network communication channels within plugins.
---
---@class NetworkApi
---@field createChannel NetworkApi.createChannel
---@field invokeChannelListeners NetworkApi.invokeChannelListeners
---@field registerChannelListener NetworkApi.registerChannelListener
---@field removeChannelListener NetworkApi.removeChannelListener

---
--- Creates a new communication channel.
---
---@alias NetworkApi.createChannel fun(self: Plugin, name: string, options?: ChannelOptions)

---
--- Invokes the registered listeners for the specified
--- communication channel, passing any provided arguments.
---
---@alias NetworkApi.invokeChannelListeners fun(self: Plugin, channel: string, arguments?: unknown[])

---
--- Registers a new listener for the specified communication channel,
--- allowing the listener to react to channel events.
---
---@alias NetworkApi.registerChannelListener fun(self: Plugin, channel: string, listener: Listener)

---
--- Removes the listener associated with the specified
--- identifier from the communication channel.
---
---@alias NetworkApi.removeChannelListener fun(self: Plugin, channel: string, identifier: string)
