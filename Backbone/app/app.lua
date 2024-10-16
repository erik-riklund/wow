--[[~ Module: Application ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/18

]]

local self = _G.BackboneApp --[[@as AppFrame]]
backbone.widgetConstructors.window(self) -- parent constructor.

backbone.registerThemeableLabels {
  { object = self.logoName, colorKey = 'logoNameColor' },
  { object = self.logoSlogan, colorKey = 'logoSloganColor' },
}
backbone.registerLocalizedLabels {
  { object = self.logoSlogan, labelKey = self.logoSlogan:GetText() },
}
backbone.registerThemeableTextures {
  { object = self.menuBaseLine, colorKey = 'menuBaseLineColor' },
  { object = self.menuBaseLineShader, colorKey = 'menuBaseLineShaderColor' },
}

-- backbone.widgetConstructors.app = function(self)
--   backbone.widgetConstructors.window(self) -- parent constructor.

--   backbone.registerThemeableLabels {
--     { object = self.logoName, colorKey = 'logoNameColor' },
--     { object = self.logoSlogan, colorKey = 'logoSloganColor' },
--   }
--   backbone.registerLocalizedLabels {
--     { object = self.logoSlogan, labelKey = self.logoSlogan:GetText() },
--   }
--   backbone.registerThemeableTextures {
--     { object = self.menuBaseLine, colorKey = 'menuBaseLineColor' },
--     { object = self.menuBaseLineShader, colorKey = 'menuBaseLineShaderColor' },
--   }
-- end
