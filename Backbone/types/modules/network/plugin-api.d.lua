---@meta

---
---@class NetworkApi
---
---@field createChannel fun(self: Plugin, name: string, options?: createChannel.options)
---@field registerChannelListener fun(self: Plugin, channel: string, listener: Listener)
---@field removeChannelListener fun(self: Plugin, channel: string, identifier: string)
---@field invokeChannelListeners fun(self: Plugin, channel: string, payload?: unknown)
---
