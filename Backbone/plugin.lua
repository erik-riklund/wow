---@class Backbone
local context = select(2, ...)

--[[~ ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- The core plugin for the framework, which is used to manage
--- configuration variables used globally within the ecosystem.
---
context.plugin = backbone.createPlugin('Backbone', {
  storage = { account = true, character = true },
})

---
--- ?
---
context.plugin:onLoad(function()
  context.config = backbone.useConfigManager(context.plugin, {
    ---
    --- The name of the default color theme.
    ---
    colorTheme = 'backbone',
  })
end)
