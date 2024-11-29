
--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

---Prevents modifications to an immutable proxy.
---* Called when a write operation is attempted on a proxy.
local block_change = function() error ('Attempt to modify an immutable proxy', 3) end

---@param source table
---Creates a read-only proxy for a source table.
---* Accessing nested tables automatically creates proxies for them.
Proxy = function (source)
  local access_value = function (_, key)
    return (type (source[key]) == 'table' and Proxy(source[key])) or source[key]
  end

  return setmetatable ({}, { __index = access_value, __newindex = block_change })
end
