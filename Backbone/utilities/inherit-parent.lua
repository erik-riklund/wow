--[[~ Utility: Inheritance ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/04

  Provides a utility for inheritance, allowing a child table to
  inherit from a parent table using metatables.

]]


---
--- Allows `child` to access methods and properties from `parent`.
---
---@param child table
---@param parent table
---
backbone.utilities.inheritParent = function(child, parent)
  return setmetatable(child, { __index = parent })
end
