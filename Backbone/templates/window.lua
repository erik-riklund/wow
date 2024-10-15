--[[~ Template: Window ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

]]

---
---@class Window : BorderedFrame
---@field backgroundColor Texture
---

---@param self Window
backbone.templateConstructors.window = function(self)
  backbone.templateConstructors.borderedFrame(self) -- parent constructor.

  backbone.registerThemeableTextures {
    { object = self.backgroundColor, colorKey = 'frameBackgroundColor' },
  }
end
