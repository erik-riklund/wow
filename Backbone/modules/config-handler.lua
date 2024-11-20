---@class Backbone
local context = select(2, ...)

--[[~ Configuration handler (module) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

local config_prefix = '__config/'

---
--- ?
---
local profiles = new 'Dictionary'

---
--- ?
---
local default_settings = new 'Dictionary'

---
--- ?
---
---@param plugin Plugin
---@param key string
---
local getDefaultSetting = function(plugin, key)
  print 'configHandler.getDefaultSetting not implemented'
end

---
---@class Plugin
---
local config_api = {}

---
--- ?
---
---@param settings Dictionary
---
config_api.registerDefaultSettings = function(self, settings)
  if default_settings:hasEntry(self:getIdentifier()) then
    new(
      'Error',
      'Cannot register duplicate default settings (%s)',
      self:getIdentifier()
    )
  end

  default_settings:setEntry(self:getIdentifier(), settings)
end

---
--- ?
---
---@param key string
---
config_api.getSetting = function(self, key)
  print 'plugin.getSetting not implemented' --
end

---
--- ?
---
---@param key string
---@param value unknown
---
config_api.setSetting = function(self, key, value)
  print 'plugin.setSetting not implemented' --
end

---
--- ?
---
context.registerPluginExtension(
  function(plugin)
    plugin.getSetting = config_api.getSetting
    plugin.setSetting = config_api.setSetting
    plugin.registerDefaultSettings = config_api.registerDefaultSettings

    plugin:onLoad(
      function()
        -- TODO: implement loading of stored configuration profiles.
      end --
    )
  end --
)
