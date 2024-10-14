--[[~ Template: Window ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---
---@class Window : BorderedFrame
---@field backgroundColor Texture
---

---@param self Window
backbone.templates.window = function(self)
  backbone.templates.borderedFrame(self) -- parent constructor.

  backbone.registerThemeableTextures {
    { object = self.backgroundColor, colorKey = 'frameBackgroundColor' },
  }
end
