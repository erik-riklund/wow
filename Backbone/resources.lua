---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

---
--- A frame used internally to easily hook scripts for events, updates, etc.
---
---@type Frame
---
context.frame = B_Widget.createFrame ('Frame')

---
--- A string representation of the active locale, e.g. `enUS`.
---
backbone.activeLocale = System.getLocale ()

---
--- The number representation of the currently available expansion.
---
backbone.currentExpansion = System.getExpansion ()
