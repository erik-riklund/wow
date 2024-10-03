--[[~ Component: Listenable ~
  Created: 2024/10/03
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

---
---
---
local listenable = {
  
}

---
--- ?
---
---@return Listenable
---
backbone.components.createListenable = function()
  return setmetatable({ listeners = {} }, { __index = listenable })
end
