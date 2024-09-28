--[[~ Utility: Error Handling ~

  Version: 1.0.0 | Updated: 2024/09/24

  This utility provides a centralized error handling mechanism for the framework. It differentiates 
  between development and production modes, ensuring that detailed error messages are only displayed 
  in development, while production users receive a simplified error message.

  Features:

  - Centralized error handling with support for both development and production modes.
  - Detailed error reporting in development mode.
  - Simplified error messages for production environments.

]]

---
--- throw()
---
--- This function throws an error message in development mode. If the framework is not running in
--- production mode, the error message is formatted using any provided arguments and raised as an
--- exception. In production mode, it prints a user-friendly message to the console, advising the
--- user to reload or enable development mode for more detailed error reporting.
---
---@param exception string "The base error message, with optional format specifiers."
---@param ...       string "(optional) Arguments used to format the error message."
---
_G.throw = function(exception, ...)
  if _G.production ~= true then
    error((... and exception:format(...)) or exception, 3)
  end

  print(
    '[Backbone] The framework encountered an internal or plugin-related exception. You can try "/reload" to '
      .. 'see if the problem persists, or use "/backbone development" to enable more detailed error reporting.'
  )
end
