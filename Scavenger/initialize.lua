---@class Scavenger
local context = select(2, ...)

--[[~ Updated: 2024/11/21 | Author(s): Gopher ]]

---
--- Create the plugin.
---
context.plugin = backbone.createPlugin 'Scavenger'

---
--- Create the channel used to broadcast a list of items that remains
--- after the looting process is completed.
---
context.plugin:createChannel 'LOOT_PROCESSED'
