--[[~ Template: Bordered Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/17

]]

---
--- Initializes a bordered frame by registering its border colors.
---
---@param self BorderedFrame
---@param colorKeys? BorderedFrameColorKeys
backbone.widgetConstructors.borderedFrame = function(self, colorKeys)
  colorKeys = colorKeys or {}

  backbone.registerThemeableTextures {
    {
      object = self.topBorderColor,
      colorKey = colorKeys.topBorder or 'frameBorderColor',
    },
    {
      object = self.topBorderShader,
      colorKey = colorKeys.topBorderShader or 'frameBorderShaderColor',
    },
    {
      object = self.rightBorderColor,
      colorKey = colorKeys.rightBorder or 'frameBorderColor',
    },
    {
      object = self.rightBorderShader,
      colorKey = colorKeys.rightBorderShader or 'frameBorderShaderColor',
    },
    {
      object = self.bottomBorderColor,
      colorKey = colorKeys.bottomBorder or 'frameBorderColor',
    },
    {
      object = self.bottomBorderShader,
      colorKey = colorKeys.bottomBorderShader or 'frameBorderShaderColor',
    },
    {
      object = self.leftBorderColor,
      colorKey = colorKeys.leftBorder or 'frameBorderColor',
    },
    {
      object = self.leftBorderShader,
      colorKey = colorKeys.leftBorderShader or 'frameBorderShaderColor',
    },
  }
end
