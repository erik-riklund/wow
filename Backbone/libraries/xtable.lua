--[[

  Project: Backbone (framework)
  Library: ?
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/23

  ?

]]

---
--- ?
---
_G.xtable = {
  ---
  --- Creates a protected proxy for the given object, ensuring that the original object
  --- cannot be modified. The proxy allows access to the object's values, and if a value
  --- is a table, it creates a protected proxy for that table as well.
  ---
  --- @param object table "The table to protect from modifications."
  ---
  getProtectedProxy = function(object)
    return setmetatable({}, {
      --
      -- Prevents modifications to the protected object, ensuring that no changes can
      -- be made to its data. Any attempt to modify the object will result in an error.

      __newindex = function() error('Attempt to modify a protected object.', 3) end,

      -- Allows access to the object's values. If the value is a table, a new protected
      -- proxy is created for it to maintain the protection recursively.

      __index = function(proxy, key)
        return (type(object[key]) ~= 'table' and object[key])
          or xtable.getProtectedProxy(object[key])
      end,
    })
  end,
}
