---@meta

---@class AppFrame : WindowTemplate
---@field menuBaseLine       Texture
---@field menuBaseLineShader Texture
---@field logoName           FontString
---@field logoSlogan         FontString

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
