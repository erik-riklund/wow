--[[~ Utility: Error Handling ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/02

  Provides a utility to handle errors, throwing detailed error messages in 
  development mode, while triggering a generic error message in production mode.

]]


---
--- Throws a detailed Lua error in development mode,
--- or triggers a generic error message in production mode.
---
---@param message string
---@param ... string|number
---
_G.throw = function(message, ...)
  if not backbone.isProductionMode() then
    error((... and string.format(message, ...) or message), 3)
  end

  backbone.console.exception '?' -- Triggers the generic error message shown in production mode.
end
