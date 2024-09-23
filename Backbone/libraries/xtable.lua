--[[~ Project: Backbone (framework) ~

  Library: ?
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/23 | Updated: 2024/09/23

  ?

]]

---
--- ?
---
_G.xtable = {
  ---
  --- Creates a protected proxy for the given table, ensuring that its contents
  --- cannot be modified. This design choice helps enforce immutability, which
  --- is critical for maintaining data integrity, especially in shared systems.
  ---
  ---@param object table "The table to protect from modifications."
  ---
  getProtectedProxy = function(object)
    return setmetatable({}, {
      --
      -- Prevents any modifications to the protected table by throwing an error
      -- if an attempt is made to modify its contents. This ensures that the
      -- table remains immutable.

      __newindex = function() error('Attempt to modify a protected object.', 3) end,

      --
      -- Provides read-only access to the table's contents. If a value within
      -- the table is itself a table, it is recursively protected to ensure that
      -- all nested tables are also immutable.

      __index = function(proxy, key)
        return (type(object[key]) ~= 'table' and object[key])
          or xtable.getProtectedProxy(object[key])
      end,
    })
  end,
}
