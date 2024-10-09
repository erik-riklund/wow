---@meta

--[[~ Type: Network API ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
---@class NetworkApi
---
---@field createChannel fun(self: Plugin, name: string, options?: { internal?: boolean, async?: boolean })
---@field invokeChannelListeners fun(self: Plugin, channel: string, arguments?: unknown[])
---@field registerChannelListener fun(self: Plugin, channel: string, identifier: string, callback: function, persistent?: boolean)
---@field removeChannelListener fun(self: Plugin, channel: string, identifier: string)
---
