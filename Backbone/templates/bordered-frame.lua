--[[~ Template: Bordered Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

]]

---
---@class BorderedFrame : Frame
---@field topBorderColor Texture
---@field topBorderShader Texture
---@field rightBorderColor Texture
---@field rightBorderShader Texture
---@field bottomBorderColor Texture
---@field bottomBorderShader Texture
---@field leftBorderColor Texture
---@field leftBorderShader Texture
---

---@param self BorderedFrame
backbone.templates.borderedFrame = function(self)
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
