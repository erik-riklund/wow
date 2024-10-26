--[[~ Utility: Table Manipulation ~
  Updated: 2024/10/26 | Author(s): Erik Riklund (Gopher)
]]

---
--- Creates a deep copy of the specified table, including all nested tables.
--- Ensures that the original table and its copy are independent of each other.
---
---@param target table
---
backbone.utilities.copyTable = function(target)
  local tableCopy = {}

  for key, value in pairs(target) do
    tableCopy[key] = (type(value) == 'table' and backbone.utilities.copyTable(value)) or value
  end

  return tableCopy
end
