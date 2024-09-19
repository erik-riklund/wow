--[[

  Project: Stem (framework)
  Module: ?
  Version: 1.0.0

  Description:
  ?

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Dependencies: 
    - List any other scripts, libraries, or frameworks 
      required for this script to work.

  Usage:
    - (Optional, if needed, brief notes on how the script is used)

  Notes:
    - Any important details, todos, or implementation decisions.
    - Known issues or limitations.

]]

---
--- ?
---
--- @param target     table    "..."
--- @param source     table    "..."
--- @param overwrite? boolean  "..."
---
_G.integrateTable = function(target, source, overwrite)
  --
  -- ?

  for key, value in pairs(source) do
    if overwrite ~= true and target[key] ~= nil then
      
    end
  end

  -- ?

  return target
end
