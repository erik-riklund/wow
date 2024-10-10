--[[~ Widget: Tooltip ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@param parent Frame
_G.BackboneTooltipTemplate_OnLoad = function(parent)
  local self = parent.tooltipFrame --[[@as Frame]]

  DevTools_Dump(self)
end

---@param self Frame
_G.BackboneTooltipTemplate_ToggleState = function(self)
  self:SetShown(not self:IsShown()) --
end
