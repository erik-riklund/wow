--[[

  Project: Stem (framework)
  Utility: Table Integration
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Provides a utility function that integrates values from a source table into a target 
  table. If the `overwrite` flag is set to `true`, existing keys in the target are 
  overwritten; otherwise, an error is thrown if a key conflict occurs.

  Notes:

  - The function throws an error if the `target` table already contains a key and 
    `overwrite` is not set to `true`.

]]

---
--- Integrates values from the `source` table into the `target` table. If `overwrite`
--- is `true`, it will overwrite existing keys in the target. Otherwise, it throws an
--- error when key conflicts occur, ensuring that the integration does not accidentally
--- overwrite existing data.
---
--- @param target     table    "The table to integrate values into."
--- @param source     table    "The table from which values are taken."
--- @param overwrite? boolean  "If `true`, allows overwriting of existing keys in the target table."
---
_G.integrateTable = function(target, source, overwrite)
  --
  -- Iterates over each key-value pair in the source table. If overwrite is not enabled,
  -- it checks if the key already exists in the target and throws an error if it does.
  -- Otherwise, it integrates the value into the target table.

  for key, value in pairs(source) do
    if overwrite ~= true and target[key] ~= nil then
      exception.generic('Table integration failed, `target` already contains the key "%s".', key)
    end

    target[key] = value -- adds or overwrites the value in the target table.
  end

  -- Returns the provided `target` table after integrating the values.

  return target
end
