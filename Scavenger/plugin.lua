---@class Scavenger
local context = select(2, ...)

--[[~ ? (?) ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
context.plugin = backbone.createPlugin 'Scavenger'

---
--- ?
---
context.plugin:onLoad(function() print 'Hello world' end)
