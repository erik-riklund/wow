--[[

  Project: Stem (framework)
  Module: Table Utilities
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Provides a utility function for merging multiple tables into one. When multiple
  tables are merged, the values from later tables will overwrite those from earlier
  tables if they share the same key.

  Notes:

  - This function performs a shallow merge, so nested tables are not recursively merged.

]]

---
--- Merges multiple tables into one, with later tables overwriting values from earlier
--- ones for keys that are the same. This function is useful when combining configurations
--- or settings from various sources.
---
--- @param first  table  "The first table to merge."
--- @param second table  "The second table to merge."
--- @param ...    table  "Additional tables to merge."
---
_G.mergeTables = function(first, second, ...)
  local result = {}

  -- Iterates over all provided tables, copying key-value pairs into the result.
  -- Later tables overwrite earlier ones for matching keys.

  for index, source in ipairs { first, second, ... } do
    for key, value in pairs(source) do
      result[key] = value -- overwrites the value if the key already exists.
    end
  end

  return result
end
