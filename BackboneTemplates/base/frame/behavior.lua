--[[~ Module: Template / Frame ~
  Updated: 2024/11/05 | Author(s): Erik Riklund (Gopher)
]]

---
--- The constructor for the generic frame template.
---
---@param self BackboneFrame
---@param colors? BackboneFrameColors
---
BackboneFrameTemplate_OnLoad = function(self, colors)
  colors = colors or {}

  backbone.widgets.onThemeChange(function()
    backbone.widgets.setBorderColors(self, colors)

    local backgroundColor = colors.background or 'backgroundColor'
    backbone.widgets.setTextureColor(self.background, backgroundColor)
  end)
end
