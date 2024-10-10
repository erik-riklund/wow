--[[~ Widget: Button ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@param self Button
_G.BackboneButtonTemplate_ToggleActiveEffect = function(self)
  local activeEffect = self.activeEffect --[[@as Texture]]
  activeEffect:SetShown(not activeEffect:IsShown())
end

---@param self Button
_G.BackboneButtonTemplate_UpdateWidth = function(self)
  local _, height = self:GetSize()
  local content = (self.text --[[@as FontString]]):GetText()

  self:SetSize((#content * (#content < 25 and 7 or 6)) + 10, height)
end

---@param self Button
_G.BackboneButtonWithTooltipTemplate_OnLoad = function(self)
  print 'BackboneButtonWithTooltipTemplate_OnLoad: not implemented.'
end
