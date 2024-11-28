
--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

local environment = 'development'

---@return 'development'|'production' mode A string indicating whether the environment is in development or production mode.
---Returns the current runtime environment of the application.
backbone.getEnvironment = function () return environment end
