---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

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
