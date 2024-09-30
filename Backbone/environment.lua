--[[~ Script: Environment Toggle ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  Toggles the environment flag between 'production' and 'development',
  allowing for fine-tuned behavior depending on the active environment.

]]

local environment = 'development'

---
--- Returns `true` if production mode is active, otherwise `false`.
---
backbone.isProductionMode = function()
  return environment == 'production'
end

---
--- Set the global environment flag to `production`.
---
backbone.enableProductionMode = function()
  environment = 'production'
end

---
--- Set the global environment flag to `development`.
---
backbone.disableProductionMode = function()
  environment = 'development'
end
