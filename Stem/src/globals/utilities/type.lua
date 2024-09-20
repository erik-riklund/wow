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
--- @param value unknown "..."
--- @return extendedType "..."
---
_G.getExtendedType = function(value)
  --
  -- ?

  local valueType = type(value)

  -- ?

  if valueType == 'table' then
    -- ?

    -- todo: perform tests on tables to see how the # operator behave!
  end

  -- ?

  return (valueType == 'nil' and 'undefined') or valueType --[[@as extendedType]]
end

---
--- ?
---
--- @param value unknown "..."
--- @param types extendedType|array<extendedType> "..."
---
--- @return boolean, extendedType "..."
---
_G.compareExtendedTypes = function(value, types)
  ---@diagnostic disable-next-line: missing-return
end
