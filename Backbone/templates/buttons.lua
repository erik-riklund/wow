--[[~ Widget: Buttons ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---
--- ?
---
---@param self ButtonTemplate
---@param variables? string[]
backbone.widgetConstructors.button = function(self, variables)
  backbone.registerLocalizedLabels {
    { object = self.textLabel, labelKey = self.textLabel:GetText(), variables = variables },
  }
  backbone.registerThemeableLabels { { object = self.textLabel, colorKey = 'buttonLabelColor' } }
end

---
--- ?
---
---@param button ButtonTemplate
backbone.widgetControllers.updateButtonWidth = function(button)
  button:SetWidth(math.ceil(button.textLabel:GetStringWidth()) + 16)
end

---
--- ?
---
---@param button ButtonTemplate
backbone.widgetControllers.setButtonLabelColor = function(button)
  button.textLabel:SetTextColor(backbone.getColor 'buttonLabelColor')
end

---
--- ?
---
---@param button ButtonTemplate
backbone.widgetControllers.setButtonLabelActiveColor = function(button)
  button.textLabel:SetTextColor(backbone.getColor 'buttonLabelActiveColor')
end
