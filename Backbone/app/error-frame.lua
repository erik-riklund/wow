--[[~ Widget: Error Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---
--- ?
---
---@param self ErrorFrame
backbone.widgetConstructors.errorFrame = function(self)
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

  if not backbone.widgetControllers.setErrorFrameContent then
    ---
    --- ?
    ---
    ---@param content string
    backbone.widgetControllers.setErrorFrameContent = function(content)
      self.contentLabel:SetText(content)
    end
  end
end
