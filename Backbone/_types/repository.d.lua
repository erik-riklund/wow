---@meta

--[[~ Type: Repository ~
  Created: 2024/10/03
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
---@class Repository
---
---@field frame Frame
---@field setActivePage fun(name: string)
---@field registerPage fun(name: string, panels: { main: table, left?: table, right?: table })
---
