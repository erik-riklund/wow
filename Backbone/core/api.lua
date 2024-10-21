--[[~ Module: API ~
  
  Author(s): Erik Riklund (Gopher)
  Updated: 2024/10/21
]]

---
--- A string representation of the installed version of the framework.
---
local version = '1.0.0'

---
--- A shared frame that can be used to hook scripts (OnEvent, OnUpdate, ...) if required.
---
---@type Frame
local sharedFrame = CreateFrame('Frame', 'BackboneSharedFrame')

---
--- The core API for the Backbone framework.
---
_G.backbone = {}

---
--- ?
---
backbone.components = {}

---
--- A collection of utility functions provided by the framework.
---
backbone.utilities = {}

---
--- ?
---
backbone.widgets = {}

---
--- Returns the current version of the framework.
---
--- @return number, number, number "MAJOR, MINOR, and PATCH version numbers."
backbone.getCurrentVersion = function() return string.split('.', version) end

---
--- Returns the shared frame, enabling easy use of script hooks.
---
backbone.getSharedFrame = function() return sharedFrame end
