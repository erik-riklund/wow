---@class Backbone
local context = select(2, ...)

--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param self BackboneBorderedFrame
---@param colors BackboneBorderedFrameColors
---
local setFrameColors = function(self, colors)
  colors.background = colors.background or 'backgroundColor'
  colors.bottomBorder = colors.bottomBorder or 'borderColor'
  colors.bottomBorderShader = colors.bottomBorderShader or 'borderShaderColor'
  colors.leftBorder = colors.leftBorder or 'borderColor'
  colors.leftBorderShader = colors.leftBorderShader or 'borderShaderColor'
  colors.rightBorder = colors.rightBorder or 'borderColor'
  colors.rightBorderShader = colors.rightBorderShader or 'borderShaderColor'
  colors.topBorder = colors.topBorder or 'borderColor'
  colors.topBorderShader = colors.topBorderShader or 'borderShaderColor'

  for object, colorKey in pairs(colors) do
    (self[object] --[[@as Texture]]):SetColorTexture(backbone.getColor(colorKey))
  end
end

---
--- ?
---
---@param self BackboneBorderedFrame
---@param colors? BackboneBorderedFrameColors
---
BackboneBorderedFrame_OnLoad = function(self, colors)
  backbone.registerThemeableWidget(function() setFrameColors(self, colors or {}) end)
end
