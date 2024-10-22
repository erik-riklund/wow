--[[~ Module: Framework ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- A string representation of the installed version of the framework.
---
local version = '1.0.0'

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
