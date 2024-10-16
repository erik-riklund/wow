--[[~ Template: Window ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

]]



---@param self WindowTemplate
backbone.widgetConstructors.window = function(self)
  backbone.widgetConstructors.borderedFrame(self) -- parent constructor.

  self:RegisterForDrag 'LeftButton'
  backbone.registerThemeableTextures {
    { object = self.backgroundColor, colorKey = 'frameBackgroundColor' },
  }
end


