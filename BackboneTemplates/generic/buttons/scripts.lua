--[[~ Scripts: Generic Buttons ~
  Updated: 2024/11/11 | Author(s): Erik Riklund (Gopher)
]]

---
--- Initializes the button and applies localized text, theme updates, and hover behavior.
---
---@param self BackboneButtonTemplate
---
BackboneButtonTemplate_OnLoad = function(self)
  BackboneButtonTemplate_SetLocalizedText(self, self.label:GetText())

  backbone.widgets.onThemeChange(function()
    BackboneBorderTemplate_SetBorderColors(self, 'buttonBorderColor')
    BackboneBorderTemplate_SetBorderShaderColors(self, 'buttonBorderShaderColor')

    backbone.widgets.setTextureColor(self.highlight, 'buttonHighlightColor')
    backbone.widgets.setTextureColor(self.background, 'buttonBackgroundColor')
    backbone.widgets.setFontColor(self.label, 'buttonLabelColor')
  end)

  self:HookScript('OnEnter', function()
    self.highlight:SetShown(true)
    backbone.widgets.setFontColor(self.label, 'buttonLabelHighlightColor')
  end)

  self:HookScript('OnLeave', function()
    self.highlight:SetShown(false)
    backbone.widgets.setFontColor(self.label, 'buttonLabelColor')
  end)
end

---
--- Sets the localized text for the button label based on the provided key path.
---
---@param self BackboneButtonTemplate
---@param keyPath string
---
BackboneButtonTemplate_SetLocalizedText = function(self, keyPath)
  ---@type string, string
  local namespace, key = string.split(':', keyPath, 2)
  self.label:SetText(backbone.getLocalizedString(namespace, key))

  BackboneButtonTemplate_AdjustSize(self)
end

---
--- Adjusts the button size to fit its content (with optional padding).
---
---@param self BackboneButtonTemplate
---@param paddingX? number
---@param paddingY? number
---
BackboneButtonTemplate_AdjustSize = function(self, paddingX, paddingY)
  local defaultPaddingX, defaultPaddingY = 9, 5
  local contentWidth = self.label:GetStringWidth()
  local contentHeight = self.label:GetStringHeight()

  self:SetWidth(backbone.utilities.adjustToEven( --
    contentWidth + ((paddingX or defaultPaddingX) * 2)
  ))
  self:SetHeight(backbone.utilities.adjustToEven( --
    contentHeight + ((paddingY or defaultPaddingY) * 2)
  ))
end
