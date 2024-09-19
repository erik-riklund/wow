--[[

  Project: Stem (framework)
  Utility: Object Inheritance
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Provides a utility function that allows a child object to inherit from a parent object 
  by setting the parent as the metatable. This enables the child object to access properties 
  and methods defined on the parent.

  Notes:

  - The function checks if the child already has a metatable (parent) and throws an error 
    if it does, preventing accidental overwriting of an existing parent.

]]

---
--- Allows a child object to inherit from a parent by setting the parent as the metatable
--- of the child. If the child already has a metatable, the function will throw an error,
--- ensuring that an existing parent is not accidentally overwritten.
---
--- @param child  table  "The child object that will inherit from the parent."
--- @param parent table  "The parent object whose properties and methods will be accessible to the child."
---
_G.inheritFromParent = function(child, parent)
  if getmetatable(child) ~= nil then
    exception.generic 'Object inheritance failed, "child" already has a parent (metatable).'
  end

  return setmetatable(child, { __index = parent })
end
