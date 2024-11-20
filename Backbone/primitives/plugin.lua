---@class Backbone
local context = select(2, ...)

--[[~ Plugin (domain primitive) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@class Plugin
---
local plugin_api = {}

---
--- ?
---
plugin_api.getIdentifier = function(self) return self.identifier end

---
--- ?
---
context.registerPluginExtension(
  function(plugin) plugin.getIdentifier = plugin_api.getIdentifier end --
)
