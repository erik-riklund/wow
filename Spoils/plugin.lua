---@class Spoils
local context = select(2, ...)

--[[~ Plugin: Spoils ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local plugin = backbone.createPlugin('Spoils', {
  storage = { account = true, character = true },
})
