---@meta

--[[~ Type: Application Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/13

]]

---
---@class ApplicationController
---
---@field registerModule fun(module: Module)
---@field getRegisteredModules fun(): Module[]
---@field setActiveModule fun(name: string)
---@field setActivePanel fun(module: string, panel: string)
---
