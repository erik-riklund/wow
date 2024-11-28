
--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---@param message string
---@param ... string|number
---?
backbone.throw = function(message, ...)
  if backbone.getEnvironment() == 'development' then
    error(... and string.format(message, ...) or message, 3)
  end
  
  --TODO: handle errors in production mode.
  --backbone.print ('A generic error message')
end
