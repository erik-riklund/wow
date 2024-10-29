---@class Backbone
local context = select(2, ...)

--[[~ Module: Resources ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---
--- Used as the owner for protected framework channels, prior to creating
--- the actual core plugin once the framework is initialized.
---
context.plugin = { identifier = 'backbone', name = 'Backbone' }

---
--- A shared frame that can be used to hook scripts (OnEvent, OnUpdate, ...).
---
---@type Frame
local sharedFrame = CreateFrame('Frame', 'BackboneSharedFrame')

---
--- Returns the shared frame, enabling easy use of script hooks.
---
backbone.getSharedFrame = function() return sharedFrame end
