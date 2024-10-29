---@class Backbone
local context = select(2, ...)

--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- Create the core plugin for the framework, which is used to manage
--- configuration variables used globally within the ecosystem.
---
context.plugin = backbone.createPlugin('Backbone', {
  storage = { account = true, character = true },
})

---
--- ?
---
context.config = backbone.useConfigManager(context.plugin, {})
