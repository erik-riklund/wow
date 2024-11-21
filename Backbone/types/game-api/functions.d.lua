---@meta

---
--- Creates a `Frame` object.
---
---@type fun(frame_type: FrameType, name?: string, parent?: Frame, template?: string, id?: number): Frame
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
--- Returns info for a loot slot.
--- 
---@type fun(slot: number): icon: string, name: string, quantity: number, currency_id: number?, quality: number, locked: boolean, quest_item: boolean, quest_id: number, active: boolean
---
GetLootSlotInfo = function() end

---
--- Returns the item link for a loot slot.
---
---@type fun(slot: number): link: string
---
GetLootSlotLink = function() end

---
--- Returns an integer loot type for a given loot slot.
---
---@type fun(slot: number): type: number
---
GetLootSlotType = function() end

---
--- Returns the number of items in the loot window.
---
---@type fun(): item_count: number
---
GetNumLootItems = function() end

---
--- Returns the system uptime in seconds, with millisecond precision.
---
---@type fun(): seconds: number
---
GetTime = function() end

---
--- Loots the specified slot.
--- 
---@type fun(slot: number)
---
LootSlot = function() end

---
--- Splits a string using a delimiter (optionally: into a specified number of pieces).
---
---@type fun(delimiter: string, target: string, pieces?: number): ...: string
---
_G.strsplit = function() end

---
--- Returns `true` if a friendly unit is AFK (away from keyboard).
---
---@type fun(unit: string): is_afk: boolean
---
UnitIsAFK = function(unit) end

---
--- Returns the level of the unit.
---
---@type fun(unit: string): level: number
---
UnitLevel = function(unit) end
