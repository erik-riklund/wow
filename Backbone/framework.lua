local api = { framework = {}, plugin = {} }

--[[

  Project: Backbone (framework)  
  Version: 1.0.0
  
  Author(s): Erik Riklund

  Description:
  Backbone is a foundational framework that provides key utilities and structures 
  to streamline the development of addons. It includes features such as ...

]]

--#region [module: plugins]

--[[

  Module: ?
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  ?

  Dependencies:

  - ?

  Notes:

  - ?

]]

---
--- ?
---
--- @type table<string, plugin>
---
local plugins = {}

---
--- ?
---
--- @param identifier string "..."
--- @return plugin "..."
---
api.framework.createPlugin = function(identifier)
  --
  -- ?

  if plugins[identifier] ~= nil then
  end

  -- ?

  plugins[identifier] = setmetatable({ identifier = identifier }, { __index = api.plugin })

  -- ?

  return createProtectedProxy(plugins[identifier])
end

--#endregion

---
--- ?
---
_G.backbone = createProtectedProxy(api.framework) --[[@as api]]
