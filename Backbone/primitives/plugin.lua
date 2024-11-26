---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

---@class Plugin
local plugin_api = {}

---@return string identifier The unique identifier of the plugin.
---Retrieves the unique identifier for the plugin.
plugin_api.getIdentifier = function (self) return self.identifier end

---Extends the plugin object to include the `getIdentifier` method.
context.registerPluginExtension(
  function (plugin) plugin.getIdentifier = plugin_api.getIdentifier end
)
