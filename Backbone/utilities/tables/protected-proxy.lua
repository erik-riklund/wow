--[[~ Utility: Table Protection ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/02

  Provides a mechanism to create protected tables, preventing modifications to the
  original table by intercepting writes and ensuring safe access to nested tables.

]]

local blockModifications = function()
  error 'Attempt to modify a protected table.'
end

---
--- Creates a read-only proxy that reference the provided table.
---
---@param target table
---
backbone.createProtectedProxy = function(target)
  local proxy = {
    __newindex = blockModifications,

    __index = function(self, key)
      if type(target[key]) ~= 'table' then return target[key] end
      return backbone.createProtectedProxy(target[key])
    end,
  }

  return setmetatable({}, proxy)
end
