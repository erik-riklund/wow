--[[~ Scripts: Generic Frame Template ~
  Updated: 2024/11/10 | Author(s): Erik Riklund (Gopher)
]]

---
--- Initializes a `BackboneFrameTemplate` object, setting up its appearance based on the current theme.
--- This function is called when the frame loads, ensuring that the frame's borders and background colors
--- are updated according to the theme whenever a theme change event occurs.
---
---@param self BackboneFrameTemplate
---
BackboneFrameTemplate_OnLoad = function(self)
  backbone.widgets.onThemeChange(function()
    BackboneBorderTemplate_SetBorderColors(self)
    BackboneBorderTemplate_SetBorderShaderColors(self)

    backbone.widgets.setTextureColor(self.background, 'backgroundColor')
  end)
end
