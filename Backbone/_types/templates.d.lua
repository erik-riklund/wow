---@meta

---@class BorderedFrame : Frame
---@field topBorderColor      Texture
---@field topBorderShader     Texture
---@field rightBorderColor    Texture
---@field rightBorderShader   Texture
---@field bottomBorderColor   Texture
---@field bottomBorderShader  Texture
---@field leftBorderColor     Texture
---@field leftBorderShader    Texture

---@class BorderedFrameWithBackground : BorderedFrame
---@field backgroundColor Texture

---@class BorderedFrameColorKeys
---@field topBorder?           string
---@field topBorderShader?     string
---@field rightBorder?         string
---@field rightBorderShader?   string
---@field bottomBorder?        string
---@field bottomBorderShader?  string
---@field leftBorder?          string
---@field leftBorderShader?    string

---@class ButtonTemplate : Button
---@field textLabel FontString

---@class ButtonTemplateOptions
---@field labelColorKey? string
---@field variables? string[]

---@class ButtonWithTooltipTemplate : ButtonTemplate, WidgetWithTooltip

---@class NotificationFrameTemplate : BorderedFrameWithBackground
---@field contentLabel  FontString
---@field dismissLabel  FontString
---@field isHovering    boolean
---@field lastHovered   number

---@class NotificationFrameTemplateOptions
---@field colorKeys? NotificationFrameTemplateColorKeys
---@field closeDelay? number

---@class NotificationFrameTemplateColorKeys : BorderedFrameColorKeys
---@field backgroundColor?   string
---@field textColor?         string
---@field dismissLabelColor? string

---@class WidgetWithTooltip : Frame
---@field tooltipAnchorPoint  FontString
---@field tooltipContent      FontString

---@class WindowTemplate : BorderedFrameWithBackground
