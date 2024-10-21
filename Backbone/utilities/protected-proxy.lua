--[[~ Utility: Protected Proxy ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- Blocks any attempt to modify a protected proxy,
--- throwing an error when such an action is attempted.
---
local blockModifications = function()
  error('Blocked attempt to modify a protected proxy.', 3) --
end

---
--- Creates a protected proxy for the provided source table, preventing
--- modifications and recursively applying protection to nested tables.
--- 
--- Cached proxies are used for performance.
---
---@param source table
---
backbone.utilities.createProtectedProxy = function(source)
  local cache = setmetatable({}, { __mode = 'v' })

  return setmetatable({}, {
    __newindex = blockModifications,
    __index = function(_, key)
      local value = source[key]

      if type(value) == 'table' then
        if cache[value] == nil then
          cache[value] = backbone.utilities.createProtectedProxy(value) --
        end

        return value
      end

      return source[key]
    end,
  })
end
