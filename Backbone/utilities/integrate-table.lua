--[[~ Utility: Table Integration ~
  
  Author(s): Erik Riklund (Gopher)
  Updated: 2024/10/21
]]

---
--- Integrates the source table into the base table.
--- Throws an exception if a key already exists and overwriting is not allowed.
---
---@param baseTable table
---@param sourceTable table
---@param allowOverwriting? boolean
---
backbone.utilities.integrateTable = function(baseTable, sourceTable, allowOverwriting)
  for sourceKey, sourceValue in pairs(sourceTable) do
    if baseTable[sourceKey] ~= nil and allowOverwriting ~= true then
      backbone.throwException(
        'Table integration failed. The key "%s" already exists in the base table.',
        sourceKey
      )
    end

    baseTable[sourceKey] = sourceValue
  end
end
