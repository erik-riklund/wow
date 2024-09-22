--[[

  Project: Backbone (framework)
  Utility: Protected Proxy Creation
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Provides a utility function to create a protected proxy for a given table. The proxy 
  prevents modifications to the table while still allowing access to its values, ensuring 
  the integrity of the object.

  Notes:

  - This function recursively creates proxies for nested tables, preserving protection 
    even in deeply nested structures.

]]

---
--- Creates a protected proxy for the given object, ensuring that the original object
--- cannot be modified. The proxy allows access to the object's values, and if a value
--- is a table, it creates a protected proxy for that table as well.
---
--- @param object table "The table to protect from modifications."
---
_G.createProtectedProxy = function(object)
  return setmetatable({}, {
    --
    -- Prevents modifications to the protected object, ensuring that no changes can
    -- be made to its data. Any attempt to modify the object will result in an error.

    __newindex = function()
      error('Attempt to modify a protected object.', 3)
    end,

    -- Allows access to the object's values. If the value is a table, a new protected
    -- proxy is created for it to maintain the protection recursively.

    __index = function(proxy, key)
      return (type(object[key]) ~= 'table' and object[key]) or createProtectedProxy(object[key])
    end,
  })
end
