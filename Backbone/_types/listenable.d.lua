---@meta

--[[~ Type: Listenable ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/07

  Defines the API for the Listenable component.

]]

---
---@class Listenable
---@field listeners? Listener[]
---
---@field invokeListeners fun(self: Listenable, arguments?: unknown[], async?: boolean)
---@field registerListener fun(self: Listenable, identifier: string, callback: function, persistent?: boolean)
---@field removeListener fun(self: Listenable, identifier: string)
---
