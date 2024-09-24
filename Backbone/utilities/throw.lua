--[[~ Utility: Error Handling ~

  Version: 1.0.0 | Updated: 2024/09/24

  This utility provides a global `throw` function for raising formatted exceptions.
  The function accepts an error message and optional formatting arguments, making
  it easier to generate consistent error messages throughout the codebase.

  Design choices:
  - The `throw` function uses Lua's `error` function to raise exceptions at the
    correct stack level (level 3), allowing for proper error reporting.
  - Optional formatting arguments are supported, ensuring that error messages
    can be dynamically constructed.

]]

---
--- Raises a formatted error message.
---
--- If additional arguments are provided, they are used to format the exception message. 
--- The error is thrown at stack level 3 to correctly reflect the caller's context.
---
---@param exception string "The base error message (supports formatting)."
---@param ...       string "Optional arguments to format the error message."
---
_G.throw = function(exception, ...)
  error((... and exception:format(...)) or exception, 3)
end
