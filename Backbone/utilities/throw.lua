--[[~ Utility: Error Handling ~

  Version: 1.0.0 | Updated: 2024/09/24

  This utility provides a standardized way to raise formatted error messages 
  across the framework, making it easier to manage error handling consistently.

]]

---
--- Raises a formatted error message, using optional arguments for dynamic
--- content. The error is thrown at stack level 3, ensuring it reflects the
--- correct context from the calling function.
---
---@param exception string "The base error message, with optional format specifiers."
---@param ...       string "Optional arguments to format the error message."
---
_G.throw = function(exception, ...)
  error((... and exception:format(...)) or exception, 3)
end
