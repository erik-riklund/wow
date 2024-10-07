--[[~ Utility: Table Integration ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/07

  Provides a utility to integrate one table into another, with control
  over whether existing keys in the base table should be overwritten.

]]

---
--- Integrates the source table into the base table,
--- potentially overwriting existing keys.
---
---@param base table
---@param source table
---@param overwrite? boolean
---
utilities.integrateTable = function(base, source, overwrite)
  if type(overwrite) ~= 'boolean' then overwrite = false end

  for key, value in pairs(source) do
    if base[key] ~= nil and not overwrite then
      backbone.throwError('Table integration failed, the key "%s" already exists.', key)
    end

    base[key] = value
  end
end
