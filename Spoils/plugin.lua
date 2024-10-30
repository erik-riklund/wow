---@class Spoils
local context = select(2, ...)

--[[~ Plugin: Spoils ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

context.plugin = backbone.createPlugin('Spoils', {
  storage = { account = true, character = true },
})
