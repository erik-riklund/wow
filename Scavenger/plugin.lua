local addon, context = ...

---@type configService
local createConfigHandler = backbone.useService 'config'

--[[~ Project: Scavenger ~

  Author(s): Erik Riklund  
  Version: 1.0.0 | Updated: 2024/09/24

  ?

]]

-- ?

local plugin = backbone.createPlugin(addon)

-- ?

backbone.useStorage(plugin, {
  account = 'ScavengerAccount',
  character = 'ScavengerCharacter',
})

-- ?

local config = createConfigHandler(plugin, {})
