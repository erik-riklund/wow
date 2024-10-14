---@meta

---@alias Color number[]
---@class Theme : { [string]: Color }
---@class ThemeableTexture : { object: Texture, colorKey: string }
---@class ThemeableWidget : { object: Texture|FontString, method: 'SetColorTexture'|'SetTextColor', colorKey: string }