--[[~ Module: Backbone API ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

]]

-- The core API for the Backbone framework.
_G.backbone = {
  --
  -- A string representation of the installed version of the framework.
  version = '1.0.0',

  --
  -- ?
  sharedFrame = CreateFrame('Frame', 'BackboneSharedFrame') --[[@as Frame]],

  --
  -- ?
  widgetConstructors = {},

  --
  -- ?
  widgetControllers = {},

  --
  -- A collection of utility functions provided by the framework.
  utilities = {}
}

---
--- Returns the current version of the framework, split into MAJOR, MINOR, and PATCH numbers.
---
--- @return number, number, number "MAJOR, MINOR, and PATCH version numbers."
backbone.getCurrentVersion = function() return string.split('.', backbone.version) end
