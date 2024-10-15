---@meta

---@alias Color number[]
---@class Theme : { [string]: Color }

---@class ThemeableLabel : { object: FontString, colorKey: string }
---@class ThemeableTexture : { object: Texture, colorKey: string }
---@class ThemeableWidget : { object: FontString|Texture, method: 'SetTextColor'|'SetColorTexture', colorKey: string }
