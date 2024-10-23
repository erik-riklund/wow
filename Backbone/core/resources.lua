--[[~ Module: Resources ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---@class Backbone
local context = select(2, ...)

---
--- Used as the owner for protected framework channels.
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
