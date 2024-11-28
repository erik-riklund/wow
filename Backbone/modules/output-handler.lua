---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---@param message string
---@param ... string|number
---?
backbone.print = function (message, ...) end

---@param message string
---@param ... string|number
---?
backbone.debug = function (message, ...)
  if backbone.getEnvironment() == 'development' then
    --?
  end
end

---@class Plugin
local output_api = {}

---@param message string
---@param ... string|number
---?
output_api.print = function (self, message, ...) end

---@param message string
---@param ... string|number
---?
output_api.debug = function (self, message, ...) end

---@param message string
---@param ... string|number
---?
output_api.error = function (self, message, ...) end

---?
context.registerPluginExtension(
  function (plugin) integrateTable(plugin, output_api) end
)
