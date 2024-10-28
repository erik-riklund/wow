---@meta

---
--- ?
---
---@alias LootHandler fun(slotInfo: LootSlotInfo): shouldBeLooted: boolean

---
--- ?
---
---@class CommandHandler
---
---@field identifier string
---@field command? string
---@field commands? string[]
---@field callback fun(message: string)
