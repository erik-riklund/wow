--[[~ Utility: Inherit Parent ~
  
  Author(s): Erik Riklund (Gopher)
  Updated: 2024/10/21
]]

---
--- Allows a child table to inherit from a parent table using metatables.
---
---@param child table
---@param parent table
---
backbone.utilities.inheritParent = function(child, parent)
  return setmetatable(child, { __index = parent }) --
end
