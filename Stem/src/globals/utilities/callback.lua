--[[

  Project: Stem (framework)
  Module: ?
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/20 | Updated: 2024/09/20

  Description:
  ?

  Dependencies: 

  - ?

  Notes:

  - ?

  Usage:

  ?

]]

---
--- ?
---
--- @param identifier string    "..."
--- @param callback   function  "..."
--- @param arguments? unknown[] "..."
---
_G.executeCallback = function(identifier, callback, arguments)
  --
  -- ?

  validateArguments {
    { label = 'identifier', value = identifier, types = 'string' },
    { label = 'callback', value = callback, types = 'function' },
    { label = 'arguments', value = arguments, types = 'array', optional = true },
  }

  -- ?

  
end
