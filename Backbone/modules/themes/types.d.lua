---@meta

---
--- Represents a color in RGBA format, as an array of numbers.
---
---@alias Color number[]

---
--- Defines a theme consisting of named colors.
---
---@class Theme : { [string]: Color }

---
--- Represents a text label that can be themed.
---
---@class ThemeableLabel
---@field object FontString
---@field colorKey string

---
--- Represents a texture that can be themed.
---
---@class ThemeableTexture
---@field object Texture
---@field colorKey string

---
--- Defines a widget that can be themed, containing a reference to
--- either a label or texture, the method used to apply the color,
--- and the associated color key.
---
---@class ThemeableWidget
---@field object FontString|Texture
---@field method 'SetTextColor'|'SetColorTexture'
---@field colorKey string
