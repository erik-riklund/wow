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
--- @type context
---
local context = {
  --
  -- ?

  use = function(self, identifier) end,

  -- ?

  expose = function(self, identifier, object) end,
}

---
--- ?
---
--- @param object table
---
_G.integrateContextProvider = function(object)
  return integrateTable(object, context)
end
