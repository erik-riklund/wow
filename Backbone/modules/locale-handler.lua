---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class Plugin
local locales_api = {}

context.registerPluginExtension(
  function (plugin) integrateTable (plugin, locales_api) end
)


