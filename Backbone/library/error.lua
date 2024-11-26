
--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

---@param message string
---@param ... string|number
---Throws a formatted error message with optional arguments.
---* If arguments are provided, the message is formatted using `string.format`.
---* The error is raised at the third call level for better debugging context.
Error = function(message, ...)
  error(... and string.format(message, ...) or message, 3)
end
