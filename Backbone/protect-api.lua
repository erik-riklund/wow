--[[~ Script: API Protection ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/02

  Protects the framework API by preventing accidental modifications,
  ensuring its integrity during runtime.

]]

---@type hashmap<table, table>
local proxies = setmetatable({}, { __mode = 'v' })

---
--- In order to not lose the automatic type inference from the API declarations across
--- the framework, the table protection utility is manually defined here as well.
---
setmetatable(_G.backbone, {
  __newindex = function()
    error('Modifications to the framework API are not allowed.', 3)
  end,

  __index = function(self, key)
    -- Non-table values are returned as they are.
    if type(self[key]) ~= 'table' then return self[key] end

    -- Table values are returned wrapped in a protected proxy.
    -- Proxies are cached for efficiency.

    if proxies[self[key]] == nil then
      proxies[self[key]] = backbone.createProtectedProxy(self[key])
    end

    return proxies[self[key]]
  end,
})
