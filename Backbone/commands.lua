---@class Backbone
local context = select(2, ...)

--[[~ Command: Environment Toggle ~
  Updated: 2024/11/11 | Author(s): Erik Riklund (Gopher)
]]

backbone.registerCommandHandler {
  commands = { 'env', 'environment' },
  identifier = 'BackboneEnvironmentToggle',
  --
  callback = function()
    local environment = backbone.getEnvironment()
    backbone.setEnvironment( --
      (environment == 'development' and 'production') or 'development'
    )

    backbone.broadcast(
      'INFO', --
      'The %s environment is now active.',
      string.upper(backbone.getEnvironment())
    )
  end,
}
