--[[~ Script: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

local frame = _G.BackboneFrame --[[@as Frame]]

---@type Button
local TopMenuCloseButton = _G['BackboneFrameTopMenuPanelCloseButton']
TopMenuCloseButton:HookScript('OnClick', function() frame:SetShown(false) end)
