--[[~ Widget: Buttons ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/13

]]

---@param self Button
_G.BackboneButtonTemplate_OnLoad = function(self)
  local label = self.textLabel --[[@as FontString]]
  local plugin, localeKey = string.split(':', label:GetText())

  label:SetText(backbone.getLocalizedString(plugin, localeKey))
end

---@param self Button
_G.BackboneButtonTemplate_ToggleActiveEffect = function(self)
  Backbone_ToggleState(self.activeEffect --[[@as Texture]])
end

---@param self Button
_G.BackboneButtonTemplate_SetStaticColor = function(self)
  (self.textLabel --[[@as FontString]]):SetTextColor(0.96, 0.87, 0.7)
end

---@param self Button
_G.BackboneButtonTemplate_SetActiveColor = function(self)
  (self.textLabel --[[@as FontString]]):SetTextColor(1, 0.82, 0)
end

---@param self Button
_G.BackboneButtonTemplate_UpdateWidth = function(self)
  local _, height = self:GetSize()
  local width = (self.textLabel --[[@as FontString]]):GetWidth()

  self:SetSize(width + 16, height)
end

---@param self Button
_G.BackboneButtonWithTooltipTemplate_OnLoad = function(self)
  local textLabel = self.textLabel --[[@as FontString]]

  if backbone.utilities.stringHasPrefix(textLabel:GetText(), '[') then
    BackboneTooltipTemplate_OnLoad(self.tooltipFrame --[[@as Frame]], {})
    return -- early exit.
  end

  -- Break down the label to extract the text for the tooltip.
  local content = string.sub(textLabel:GetText(), 1, #textLabel:GetText() - 1)
  local label, tooltip = string.split('[', backbone.processMarkup(content), 2)

  -- Update the button label and populate the tooltip.
  textLabel:SetText(label)
  local lines = { string.split('/', tooltip) }
  BackboneTooltipTemplate_OnLoad(self.tooltipFrame --[[@as Frame]], lines)
end
