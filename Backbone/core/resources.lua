--[[~ Module: Resources ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local _, context = ...

---
--- ?
---
context.plugin = { identifier = 'backbone' }

---
--- A shared frame that can be used to hook scripts (OnEvent, OnUpdate, ...) if required.
---
---@type Frame
local sharedFrame = CreateFrame('Frame', 'BackboneSharedFrame')

---
--- Returns the shared frame, enabling easy use of script hooks.
---
backbone.getSharedFrame = function() return sharedFrame end
