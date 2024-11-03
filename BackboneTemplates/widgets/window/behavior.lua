--[[~ Template: Window (dismissable frame) ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param self BackboneWindowTemplate
---@param colors? BackboneWindowTemplateColors
---
BackboneWindowTemplate_OnLoad = function(self, colors)
  backbone.widgets.makeMovable(self)

  backbone.widgets.onThemeChange(function()
    backbone.widgets.setBorderColors(self, colors)
    self.background:SetColorTexture(
      backbone.getColor((colors and colors.background) or 'backgroundColor') --
    )
  end)
end
