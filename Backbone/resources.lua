---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

---@type Frame
---A frame used internally by the framework for event handling, updates, and other scripting purposes.
---* This frame serves as a central hub for hooking scripts and managing game-related events.
context.frame = B_Widget.createFrame ('Frame')

---@type string
---The active locale of the game client, represented as a string (e.g., "enUS", "deDE").
---* This value reflects the language and regional settings of the client.
backbone.activeLocale = System.getLocale ()

---@type number
---The current expansion level of the game, represented as a number.<br/>
---`0 = Classic, 1 = The Burning Crusade, ...`
backbone.currentExpansion = System.getExpansion ()
