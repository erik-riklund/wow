---@class Spoils
local context = select(2, ...)

--[[~ Plugin: Spoils ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

context.plugin = backbone.createPlugin('Spoils', {
  storage = { account = true, character = true },
})

-- context.plugin:registerChannelListener(
--   'LOOT_PROCESSED',
--   { callback = function(slots) DevTools_Dump(slots) end }
-- )