--[[~ Scripts: Generic Buttons ~
  Updated: 2024/11/10 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
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
--- ?
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
--- ?
---
---@param self BackboneButtonTemplate
---@param paddingX? number
---@param paddingY? number
---
BackboneButtonTemplate_AdjustSize = function(self, paddingX, paddingY)
  local defaultPaddingX, defaultPaddingY = 9, 5
  local contentWidth = backbone.utilities.adjustToEven(self.label:GetStringWidth())
  local contentHeight = backbone.utilities.adjustToEven(self.label:GetStringHeight())

  self:SetWidth(backbone.utilities.adjustToEven(contentWidth + ((paddingX or defaultPaddingX) * 2)))
  self:SetHeight(backbone.utilities.adjustToEven(contentHeight + ((paddingY or defaultPaddingY) * 2)))
end
