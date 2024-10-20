---@meta

---@class AppFrame : WindowTemplate
---@field contentPanel AppFrame.ContentPanel
---@field logoName FontString
---@field logoSlogan FontString
---@field menuBaseLine Texture
---@field menuBaseLineShader Texture
---@field sidePanel AppFrame.SidePanel

---@class AppFrame.ContentPanel
---@field backgroundColor Texture

---@class AppFrame.SidePanel
---@field backgroundColor Texture
---@field separatorColor Texture
---@field separatorShader Texture

---@class ErrorFrame : NotificationFrameTemplate
---@field isInitialized boolean

---@class TooltipFrame : BorderedFrameWithBackground
---@field arrowBase Texture
---@field arrowCenter Texture
---@field arrowTip Texture
---@field textLabel FontString

---@class TooltipFrame.AnchorPoint
---@field point FramePoint
---@field relativePoint FramePoint
---@field offsetX number
---@field offsetY number

---@class TooltipFrame.ArrowTextures
---@field point FramePoint
---@field relativePoint FramePoint
---@field arrowBase TooltipFrame.ArrowSegment
---@field arrowCenter TooltipFrame.ArrowSegment
---@field arrowTip TooltipFrame.ArrowSegment

---@class TooltipFrame.ArrowSegment
---@field width number
---@field height number
---@field offsetX number
---@field offsetY number

---@class ShortcutFrame : TooltipFrame
