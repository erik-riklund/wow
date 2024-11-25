
--[[~ Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher) ]]

---
--- ?
---
local blockModification = function()
  error('Attempt to modify an immutable proxy', 3) --
end

---
--- ?
---
---@param source table
---
Proxy = function(source)
  local returnValue = function(_, key)
    if type(source[key]) == 'table' then
      return new('Proxy', source[key]) --
    end

    return source[key]
  end

  return setmetatable({}, { __index = returnValue, __newindex = blockModification })
end
