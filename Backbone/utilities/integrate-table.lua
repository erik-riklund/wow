--[[~ Table Integration ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- Integrates the source table into the base table.
--- Throws an exception if a key already exists and overwriting is not allowed.
---
---@param baseTable table
---@param sourceTable table
---@param overwrite? boolean
---
backbone.utilities.integrateTable = function(baseTable, sourceTable, overwrite)
  for sourceKey, sourceValue in pairs(sourceTable) do
    if baseTable[sourceKey] ~= nil and overwrite ~= true then
      local exception = 'Table integration failed; the key "%s" already exists.'
      backbone.throwException(exception, sourceKey)
    end

    baseTable[sourceKey] = sourceValue
  end

  return baseTable
end
