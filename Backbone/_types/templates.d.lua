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

---@class BorderedFrameColorKeys
---@field topBorder?           string
---@field topBorderShader?     string
---@field rightBorder?         string
---@field rightBorderShader?   string
---@field bottomBorder?        string
---@field bottomBorderShader?  string
---@field leftBorder?          string
---@field leftBorderShader?    string

---@class ButtonTemplate : Button, { textLabel: FontString }

---@class NotificationFrameTemplate : BorderedFrame
---@field backgroundColor  Texture
---@field contentLabel     FontString
---@field dismissLabel     FontString
---@field isHovering       boolean
---@field lastHovered      number

---@class NotificationFrameTemplateOptions
---@field colorKeys? NotificationFrameTemplateColorKeys
---@field closeDelay? number

---@class NotificationFrameTemplateColorKeys : BorderedFrameColorKeys
---@field backgroundColor?   string
---@field textColor?         string
---@field dismissLabelColor? string

---@class WindowTemplate : BorderedFrame, { backgroundColor: Texture }
