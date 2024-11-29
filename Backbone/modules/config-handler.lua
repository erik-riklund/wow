---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

local config_prefix = '__config/'
local default_settings = new 'Dictionary'

---@class Plugin
local config_api = {}

context.registerPluginExtension(
  function (plugin) integrateTable (plugin, config_api) end
)

---@param settings table
---Registers default settings for the plugin.
config_api.registerDefaultSettings = function (self, settings)
  if default_settings:hasEntry (self:getIdentifier()) then
    backbone.throw ('Cannot register duplicate default settings (%s)', self:getIdentifier())
  end
  
  default_settings:setEntry (self:getIdentifier(), settings)
end


