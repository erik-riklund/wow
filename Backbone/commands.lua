--[[~ Environment Toggle ~
  Updated: 2024/11/11 | Author(s): Erik Riklund (Gopher)
]]

backbone.registerCommandHandler {
  commands = { 'env', 'environment' },
  identifier = 'BackboneEnvironmentToggle',
  --
  callback = function()
    local environment = backbone.getEnvironment()
    
    backbone.setEnvironment((environment == 'development' and 'production') or 'development')
    backbone.broadcast('INFO', 'Backbone', 'The environment is now running in %s mode.', backbone.getEnvironment())
  end,
}
