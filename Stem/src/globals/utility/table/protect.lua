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
--- @param object table "..."
---
_G.createProtectedProxy = function(object)
  return setmetatable(object, {
    --
    -- ?

    __newindex = function() error('Attempt to modify a protected object.', 3) end,

    -- ?

    __index = function(proxy, key) end,
  })
end
