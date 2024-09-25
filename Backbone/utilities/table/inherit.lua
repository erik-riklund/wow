--[[~ Module: Inheritance Utility ~

  Version: 1.0.0 | Updated: 2024/09/25

  This module provides a utility function for enabling inheritance between tables.
  It allows a child table to inherit properties and methods from a parent table
  by setting the parent as the child's metatable.

  Developer's notes:

  - The function ensures that both `child` and `parent` are valid tables before
    establishing the inheritance relationship.
  
  - Inheritance is established by setting the `__index` metamethod on the child
    table to reference the parent, allowing it to access properties and methods
    from the parent table.

]]

---
--- Establishes inheritance between the `child` and `parent` tables. The child
--- will inherit properties and methods from the parent via the `__index` metamethod.
---
---@param child   table "The child table that will inherit from the parent."
---@param parent  table "The parent table to inherit from."
---
_G.inheritParent = function(child, parent)
  -- Ensure both child and parent are tables before proceeding.
  if type(child) ~= 'table' or type(parent) ~= 'table' then
    throw 'Invalid input: both `child` and `parent` must be tables.'
  end

  -- Set the parent table as the metatable of the child, establishing inheritance.
  return setmetatable(child, { __index = parent })
end
