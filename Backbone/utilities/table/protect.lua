--[[~ Utility: Protected Proxy ~

  Version: 1.0.0 | Updated: 2024/09/26

  This utility provides a way to create a protected proxy for tables, preventing 
  any external modifications to them. The proxy ensures that attempts to modify 
  the table will result in an error. Nested tables are also recursively protected.

]]

-- Throw an error when any attempt is made to modify a protected table.
local blockModification = function()
  throw 'Attempt to modify a protected table.'
end

---
--- Creates a protected proxy for the target table, preventing any modification attempts.
--- It recursively applies protection to nested tables, ensuring all parts of the
--- structure remain immutable.
---
---@param target table "The table to protect with a proxy."
---@return table "A protected proxy of the target table."
---
_G.getProtectedProxy = function(target)
  return setmetatable({}, {
    -- Intercepts any attempt to assign a value to the table and throws an error.
    __newindex = blockModification,

    -- Provides read-only access to the target table, recursively protecting nested tables.
    __index = function(self, key)
      if type(target[key]) == 'table' then return getProtectedProxy(target[key]) end
      return target[key]
    end,
  })
end
