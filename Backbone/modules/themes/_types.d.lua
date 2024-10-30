---@meta

---
--- Represents a color in RGBA format, as an array of numbers.
---
---@alias Color number[]
---

---
--- Defines a theme consisting of named colors.
---
---@class Theme : { [string]: Color }
---

---
--- Represents a text label that can be themed.
---
---@class ThemeableLabel
---@field object FontString
---@field colorKey string
---

---
--- Represents a texture that can be themed.
---
---@class ThemeableTexture
---@field object Texture
---@field colorKey string
---

---
--- Defines a widget that can be themed, containing a label or texture object,
--- and the method used to apply the color.
---
---@class ThemeableWidget
---@field method 'SetTextColor'|'SetColorTexture'
---@field widget ThemeableLabel|ThemeableTexture
---