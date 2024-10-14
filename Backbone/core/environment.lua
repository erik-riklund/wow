--[[~ Script: Environment Toggle ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/03

  Toggles the environment flag between 'production' and 'development',
  allowing for fine-tuned behavior depending on the active environment.

]]

local environment = 'development'

---
--- Returns the currently active environment (`development` or `production`).
---
---@return 'development'|'production'
---
backbone.getEnvironment = function() return environment end

---
--- Sets the environment flag to the specified `mode`.
---
---@param mode 'development'|'production'
---
backbone.setEnvironment = function(mode) environment = mode end
