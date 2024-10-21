--[[~ Module: Environment ~
  
  Author(s): Erik Riklund (Gopher)
  Updated: 2024/10/21
]]

local environment = 'development'

---
--- Returns the currently active environment (development or production).
---
---@return 'development'|'production'
---
backbone.getEnvironment = function() return environment end

---
--- Sets the environment flag to the specified mode (development or production).
---
---@param mode 'development'|'production'
---
backbone.setEnvironment = function(mode) environment = mode end
