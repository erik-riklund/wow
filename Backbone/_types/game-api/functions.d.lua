---@meta

---
--- Creates a `Frame` object.
---
---@type fun(frameType: FrameType, name?: string, parent?: Frame, template?: string, id?: number): Frame
---
CreateFrame = function() end

---
--- Pretty prints a variable or value. Equivalent to the `/dump` macro.
---
---@type fun(value: unknown, startKey?: unknown)
---
DevTools_Dump = function() end

---
--- Returns the expansion level currently accessible by the player.
---
---@type fun(): expansionLevel: number
---
GetExpansionLevel = function() end

---
--- Returns the game client locale.
---
---@type fun(): locale: string
---
GetLocale = function() end

---
--- Returns the system uptime in seconds, with millisecond precision.
---
---@type fun(): seconds: number
---
GetTime = function() end
