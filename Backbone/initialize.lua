---@class Backbone
local context = select(2, ...)

--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
context.plugin:onLoad(function()
  backbone.setActiveColorTheme(context.config:getVariable 'colorTheme') --
end)
