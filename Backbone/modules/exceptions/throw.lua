--[[~ Module: Exceptions ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- Throws a formatted exception in development mode with the provided message and optional arguments,
--- or displays the error frame with a generic error message in production mode.
---
---@param message string
---@param ... string | number
backbone.throwException = function(message, ...)
  if backbone.getEnvironment() == 'development' then
    error((... and string.format(message, ...)) or message, 3)
  end

  backbone.displayErrorMessage '?' -- display a generic error message in production mode.
end