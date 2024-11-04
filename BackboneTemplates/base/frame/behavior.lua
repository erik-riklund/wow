--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param self BackboneFrame
---@param colors? BackboneFrameColors
---
BackboneFrameTemplate_OnLoad = function(self, colors)
  colors = colors or {}

  backbone.widgets.onThemeChange(function()
    backbone.widgets.setTextureColor( --
      self.background,
      colors.background or 'backgroundColor'
    )
    backbone.widgets.setBorderColors(self, colors)
  end)
end
