
--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---@param message string The error message to be logged or thrown. Supports formatting placeholders.
---@param ... string|number Optional arguments to format the `message` string.
---Logs or raises an error message depending on the current environment.
backbone.throw = function(message, ...)
  error ((... and string.format (message, ...)) or message, 3)
  -- if backbone.getEnvironment() == 'development' then
  --   error (message, 3) else backbone.print (message)
  -- end
end
