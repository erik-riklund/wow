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
