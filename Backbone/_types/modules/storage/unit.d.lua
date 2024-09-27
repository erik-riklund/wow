---@meta

---
--- ?
---
---@class storage.unit
---
---@field data? table "?"
---@field getEntry storage.unit.getEntry
---@field setEntry storage.unit.setEntry
---

---
--- ?
---
---@alias storage.unit.getEntry
---| fun(self: storage.unit, path: string): unknown?
---

---
--- ?
---
---@alias storage.unit.setEntry
---| fun(self: storage.unit, path: string, value: unknown)
---

---
--- ?
---
---@alias storage.unitConstructor fun(variable: table): storage.unit
---
