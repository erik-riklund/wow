---@class Scavenger
local context = select(2, ...)

--[[~ Plugin: Scavenger ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local plugin = backbone.createPlugin 'Scavenger'
context.config = backbone.useConfigManager(plugin, {})
