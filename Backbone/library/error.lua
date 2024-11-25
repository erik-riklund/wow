
--[[~ Updated: 2024/11/25 | Author(s): Erik Riklund (Gopher) ]]

---
--- Throws a formatted error message.
---
---@param message string
---@param ... string|number
---
Error = function(message, ...)
  error(... and string.format(message, ...) or message, 3)
end
