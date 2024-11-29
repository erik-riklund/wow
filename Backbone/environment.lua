---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@return 'development'|'production' mode A string indicating whether the environment is in development or production mode.
---Returns the current runtime environment of the application.
backbone.getEnvironment = function ()
  return (context.plugin:getSetting 'development' and 'development') or 'production'
end
