--[[~ Utility: Table Protection ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/02

  Provides a mechanism to create protected tables, preventing modifications to the
  original table by intercepting writes and ensuring safe access to nested tables.

]]

---@type hashmap<table, table>
local proxies = setmetatable({}, { __mode = 'v' })

---
--- Shared between all proxies for efficiency.
---
local blockModifications = function()
  error 'Attempt to modify a protected table.'
end

---
--- Creates a read-only proxy that references the provided table, granting full access
--- to the table and its children while ensuring the internal state remains immutable.
---
---@param target table
---
backbone.createProtectedProxy = function(target)
  local proxy = {
    __newindex = blockModifications,

    __index = function(self, key)
      -- Non-table values are returned as they are.
      if type(target[key]) ~= 'table' then return target[key] end

      -- Table values are returned wrapped in a protected proxy.
      -- Proxies are cached for efficiency.

      if proxies[target[key]] == nil then
        proxies[target[key]] = backbone.createProtectedProxy(target[key])
      end

      return proxies[target[key]]
    end,
  }

  return setmetatable({}, proxy)
end
