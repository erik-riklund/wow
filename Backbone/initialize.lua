---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---The public API for the Backbone framework.
_G.backbone = {}

---A container for enumerations used across the Backbone framework.
_G.ENUM = {}

---?
context.plugin_extensions = new 'Vector'

---@param callback fun(plugin: Plugin) The function to apply to each plugin.
---Registers a callback to be executed for each new plugin.
---These callbacks are used to extend plugin functionality.
context.registerPluginExtension = function (callback)
  context.plugin_extensions:insertElement (callback)
end
