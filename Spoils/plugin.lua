---@class Spoils
local context = select(2, ...)

--[[~ Spoils ~
  Updated: 2024/11/05 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
context.plugin = backbone.createPlugin('Spoils', {
  storage = { account = true, character = true },
})

---
--- ?
---
context.plugin:onLoad(function()
  context.config = backbone.useConfigManager(context.plugin, {
    -- ?
  })
end)
