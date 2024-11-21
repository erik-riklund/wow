---@class Scavenger
local context = select(2, ...)

--[[~ Loot frame integration (module) ~
  Updated: 2024/11/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
--- 
---@type table?
---
local frame_position = nil

---
--- ?
---
context.plugin:registerEventListener(
  'LOOT_OPENED',
  {
    identifier = 'HIDE_LOOT_FRAME',

    callback = function()
      print 'scavenger: hiding the loot frame (not implemented)'
    end
  }
)

---
--- ?
---

