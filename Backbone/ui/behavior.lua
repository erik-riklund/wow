--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
--- ?
---
---@param self Object
---
_G.Backbone_HideParent = function(self)
  (self:GetParent() --[[@as ScriptRegion]]):SetShown(false)
end

---
--- ?
---
---@param self ScriptRegion
---
_G.Backbone_ToggleState = function(self)
  self:SetShown(not self:IsShown()) --
end
