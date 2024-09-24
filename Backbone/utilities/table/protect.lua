--[[~ Utility: Protected Proxy ~

  Version: 1.0.0 | Updated: 2024/09/24

  This utility provides a function for creating a protected proxy for tables. 
  The proxy prevents external modification by blocking any attempts to assign new 
  values to the table. It also ensures that any nested tables are likewise protected 
  by recursively applying the proxy.

  Developer's notes:

  - The proxy uses the `__newindex` metamethod to block modifications to the target
    table, throwing an error whenever an attempt is made to change the data.

  - The proxy itself is an empty table that use the `__index` metamethod to read
    values from the `target` table, maintaining a reference to it through closure.
    If an attempt is made to alter the proxy's metatable, the reference is lost.

  - Recursive protection is applied to nested tables, ensuring that the entire 
    structure remains immutable from external modifications.

]]

---
--- Blocks any attempt to modify a protected proxy, throwing an error if an
--- assignment is made. This ensures that once a table is wrapped in a proxy,
--- it cannot be changed by external code.
---
local blockModification = function()
  throw 'Attempt to modify a protected table.'
end

---
--- Creates a protected proxy for the target table, preventing any modification
--- attempts and recursively protecting nested tables. This ensures that the table
--- and all of its contents remain read-only.
---
---@param target table "The table to be wrapped in a protected proxy."
---@return table "A read-only proxy that reference the target table."
---
_G.getProtectedProxy = function(target)
  return setmetatable({}, {
    __newindex = blockModification,
    __index = function(self, key)
      -- Recursively protect nested tables by returning proxies for them as well.
      return (type(target[key]) == 'table' and getProtectedProxy(target[key])) or target[key]
    end,
  })
end
