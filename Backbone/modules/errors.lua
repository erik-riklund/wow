--[[~ Module: Errors ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/03

  Provides a utility to handle errors, throwing detailed Lua errors in 
  development mode and displaying a generic error message in production mode.

]]

---
--- Generates a detailed error message to assist in debugging.
---
---@param message string
---@param ... string|number
---
backbone.throwError = function(message, ...)
  if backbone.getEnvironment() == 'development' then
    error((... and message:format(...)) or message, 3)
  end

  backbone.displayMessage('error', '?') -- trigger a generic error message in production mode.
end
