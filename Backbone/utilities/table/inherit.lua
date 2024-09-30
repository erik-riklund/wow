--[[~ Utility: Inherit Parent ~

  Version: 1.0.0 | Updated: 2024/09/30

  This utility allows a child table to inherit properties and methods from a parent table by setting
  the parent table as the `__index` in the child's metatable. This creates an inheritance-like relationship
  where the child gains access to the parent’s methods and properties.

]]

---
--- Establishes an inheritance-like relationship between a child table and a parent
--- table, allowing the child to access properties and methods from the parent.
---
---@param child table "The child table that will inherit properties and methods."
---@param parent table "The parent table whose properties and methods will be inherited."
---
_G.inheritParent = function(child, parent)
  if type(child) ~= 'table' or type(parent) ~= 'table' then
    throw 'Invalid input: both `child` and `parent` must be tables.'
  end

  return setmetatable(child, { __index = parent })
end
