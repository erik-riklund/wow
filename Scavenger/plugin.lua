local addon, context = ...

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

---@type configService
local createConfigHandler = backbone.useService 'config'

-- ?

local config = createConfigHandler(plugin, {})

-- ?

plugin:registerCommand('TESTING', 'test', function(message, source)
  print 'Hello world'
end)

-- expose the plugin and config objects:

context.plugin = plugin
context.config = config
