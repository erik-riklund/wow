---@class Backbone
local context = select(2, ...)

--[[~ Garbage Collection ~
  Updated: 2024/10/29 | Author(s): Erik Riklund (Gopher)
]]

---
--- Perform a full garbage collection cycle after a loading screen.
---
context.plugin:registerEventListener('PLAYER_ENTERING_WORLD', {
  callback = function() collectgarbage 'collect' end,
})
