---@class Scavenger
local context = select(2, ...)

--[[~ Plugin: Scavenger ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local plugin = backbone.createPlugin 'Scavenger'

plugin:onLoad(
  function()
    context.config = backbone.useConfigManager(plugin, {
      QUEST = { LOOT_ALL = false },
      TRADESKILL = {  }
    })
  end
)