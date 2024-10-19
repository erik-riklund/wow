---@meta

---@class AppFrame : WindowTemplate
---@field contentPanel       AppFrameContentPanel
---@field logoName           FontString
---@field logoSlogan         FontString
---@field menuBaseLine       Texture
---@field menuBaseLineShader Texture
---@field sidePanel          AppFrameSidePanel

---@class AppFrameContentPanel
---@field backgroundColor Texture

---@class AppFrameSidePanel
---@field backgroundColor Texture

---@class ErrorFrame : NotificationFrameTemplate
---@field isInitialized boolean

---@class TooltipFrame : BorderedFrameWithBackground
---@field arrowBase   Texture
---@field arrowCenter Texture
---@field arrowTip    Texture
---@field textLabel   FontString

---@class TooltipFrameAnchorPoint
---@field point         FramePoint
---@field relativePoint FramePoint
---@field offsetX       number
---@field offsetY       number

---@class TooltipFrameArrowTextures
---@field point         FramePoint
---@field relativePoint FramePoint
---@field arrowBase     TooltipFrameArrowSegment
---@field arrowCenter   TooltipFrameArrowSegment
---@field arrowTip      TooltipFrameArrowSegment

---@class TooltipFrameArrowSegment
---@field width   number
---@field height  number
---@field offsetX number
---@field offsetY number

---@class ShortcutFrame : TooltipFrame
