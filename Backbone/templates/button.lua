--[[~ Widget: Buttons ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---
--- ?
---
---@param self ButtonTemplate
---@param options? ButtonTemplateOptions
backbone.widgetConstructors.button = function(self, options)
  options = options or {}

  backbone.registerLocalizedLabels {
    {
      object = self.textLabel,
      labelKey = self.textLabel:GetText(),
      variables = options.variables,
    },
  }
  backbone.registerThemeableLabels {
    {
      object = self.textLabel,
      colorKey = options.labelColorKey or 'buttonLabelColor',
    },
  }
end

---
--- ?
---
---@param self ButtonWithTooltipTemplate
---@param options? ButtonTemplateOptions
backbone.widgetConstructors.buttonWithTooltip = function(self, options)
  backbone.widgetConstructors.button(self, options) -- parent constructor.

  self:HookScript('OnShow', function()
    local buttonText, tooltipText = string.split('[', self.textLabel:GetText())

    if tooltipText ~= nil then
      self.tooltipContent:SetText(string.sub(tooltipText, 1, #tooltipText - 1))
      backbone.widgetControllers.setButtonText(self, buttonText)
    end
  end)

  self:HookScript('OnEnter', function() backbone.widgetControllers.renderTooltip(self) end)
  self:HookScript('OnLeave', backbone.widgetControllers.hideTooltip)
end

---
--- ?
---
---@param button ButtonTemplate
---@param text string
backbone.widgetControllers.setButtonText = function(button, text)
  button.textLabel:SetText(text)
  backbone.widgetControllers.updateButtonWidth(button)
end

---
--- ?
---
---@param button ButtonTemplate
backbone.widgetControllers.updateButtonWidth = function(button)
  local contentWidth = math.ceil(button.textLabel:GetStringWidth())
  button:SetWidth(backbone.utilities.makeNumberEven(contentWidth) + 16)
end

---
--- ?
---
---@param button ButtonTemplate
---@param colorKey? string
backbone.widgetControllers.setButtonLabelColor = function(button, colorKey)
  button.textLabel:SetTextColor(backbone.getColor(colorKey or 'buttonLabelColor'))
end

---
--- ?
---
---@param button ButtonTemplate
---@param colorKey? string
backbone.widgetControllers.setButtonLabelActiveColor = function(button, colorKey)
  button.textLabel:SetTextColor(backbone.getColor(colorKey or 'buttonLabelActiveColor'))
end
