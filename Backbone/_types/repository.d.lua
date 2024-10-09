---@meta

--[[~ Type: Repository ~
  Created: 2024/10/03
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
---@class Repository
---@field frame Frame
---
---@field invokeChannelListeners fun(channel: string, arguments?: unknown[])
---@field registerPage fun(identifier: string, page: Page)
---@field setActivePage fun(identifier: string)
---
