local addon = ...

--[[

  Project: Scavenger
  Version: 1.0.0

  Author(s): Erik Riklund

  Description:
  ?

]]

-- ?

local plugin = backbone.createPlugin(addon)

-- ?

plugin:onInitialize('test', function() print 'Hello world' end)

-- ?

plugin:registerEventListener('LOOT_OPENED', {
  identifier = 'LOOT_OPENED',
  callback = function()
    print 'Loot opened.'
    plugin:removeEventListener('LOOT_OPENED', 'LOOT_OPENED')
  end,
})
