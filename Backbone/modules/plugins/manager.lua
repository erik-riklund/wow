--[[~ Module: Plugins ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local _, context = ...

---@type table<string, Plugin>
local plugins = {}

---
--- ?
---
backbone.createChannel(
  context.plugin,
  'PLUGIN_ADDED', --
  { isInternal = true, invokeAsync = false }
)

---
--- ?
---
---@param name string
---@param options any
---
backbone.createPlugin = function(name, options)
  print 'backbone.createPlugin: not implemented.' --
end
