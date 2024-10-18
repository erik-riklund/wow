--[[~ Widget: Error Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/18

]]

local self = _G.BackboneErrorFrame --[[@as ErrorFrame]]

backbone.widgetConstructors.notificationFrame(self, {
  colorKeys = {
    topBorder = 'errorFrameBorderColor',
    rightBorder = 'errorFrameBorderColor',
    bottomBorder = 'errorFrameBorderColor',
    leftBorder = 'errorFrameBorderColor',

    backgroundColor = 'errorFrameBackgroundColor',
    dismissLabelColor = 'errorFrameDismissLabelColor',
    textColor = 'errorFrameContentColor',
  },
})

---
--- Sets the text content for the error frame.
---
---@param content string
backbone.widgetControllers.setErrorFrameContent = function(content)
  self.contentLabel:SetText(content)
end
