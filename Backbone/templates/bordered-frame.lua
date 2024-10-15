--[[~ Template: Bordered Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

]]

---
--- ?
---
---@param self BorderedFrame
backbone.widgetConstructors.borderedFrame = function(self)
  backbone.registerThemeableTextures {
    { object = self.topBorderColor, colorKey = 'frameBorderColor' },
    { object = self.topBorderShader, colorKey = 'frameBorderShaderColor' },
    { object = self.rightBorderColor, colorKey = 'frameBorderColor' },
    { object = self.rightBorderShader, colorKey = 'frameBorderShaderColor' },
    { object = self.bottomBorderColor, colorKey = 'frameBorderColor' },
    { object = self.bottomBorderShader, colorKey = 'frameBorderShaderColor' },
    { object = self.leftBorderColor, colorKey = 'frameBorderColor' },
    { object = self.leftBorderShader, colorKey = 'frameBorderShaderColor' },
  }
end
