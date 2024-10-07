---@meta

---
---@class NetworkApi
---
---@field createChannel fun(self: Plugin, name: string, options?: { internal?: boolean, async?: boolean })
---@field invokeChannelListeners fun(self: Plugin, channel: string, arguments?: unknown[])
---@field registerChannelListener fun(self: Plugin, channel: string, identifier: string, callback: function, persistent?: boolean)
---@field removeChannelListener fun(self: Plugin, channel: string, identifier: string)
---
