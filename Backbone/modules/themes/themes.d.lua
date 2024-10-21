---@meta

---@alias Color number[]

---
--- ?
---
---@class Theme : { [string]: Color }

---
--- ?
---
---@class ThemeableLabel
---@field object FontString
---@field colorKey string

---
--- ?
---
---@class ThemeableTexture
---@field object Texture
---@field colorKey string

---
--- ?
---
---@class ThemeableWidget
---@field object FontString|Texture
---@field method 'SetTextColor'|'SetColorTexture'
---@field colorKey string
