---@class Backbone
local context = select(2, ...)

--[[~ Script: Garbage Collection ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

---
--- Perform a full garbage collection cycle after a loading screen.
---
backbone.registerEventListener(
  context.plugin,
  'PLAYER_ENTERING_WORLD',
  { callback = function() collectgarbage 'collect' end }
)
