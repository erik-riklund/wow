---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

---@class Plugin
local plugin_api = {}

---Extends the plugin object to include the `getIdentifier` method.
context.registerPluginExtension(
  function (plugin) integrateTable (plugin, plugin_api) end
)

---@return string identifier The unique identifier of the plugin.
---Retrieves the unique identifier for the plugin.
plugin_api.getIdentifier = function (self) return self.identifier end

---@return string name The name of the plugin, as specified when the plugin was created.
---Retrieves the name of the plugin.
plugin_api.getName = function (self) return self.name end
