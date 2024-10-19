--[[~ Widget: Shortcut Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/18

]]

local appFrame = _G.BackboneApp --[[@as AppFrame]]
local self = _G.BackboneShortcutFrame --[[@as ShortcutFrame]]

---
--- Sets the initial position for the shortcut frame.
---
local setShortcutFrameInitialPosition = function()
  self:SetPoint('BOTTOM', UIParent, 'TOP', 0, -3) --
end

---
--- Activates the shortcut frame by settings its initial position and making it visible.
---
backbone.widgetControllers.activateShortcutFrame = function()
  setShortcutFrameInitialPosition()
  self:SetShown(true)
end

---
--- Sets the active position for the shortcut frame.
---
local setShortcutFrameActivePosition = function()
  self:SetPoint('BOTTOM', UIParent, 'TOP', 0, -(self:GetHeight() - 2))
end

---
--- Initializes the shortcut frame.
---

backbone.widgetConstructors.borderedFrame(self) -- parent constructor.

backbone.registerThemeableTextures {
  { object = self.backgroundColor, colorKey = 'frameBackgroundColor' },
  { object = self.arrowBase, colorKey = 'tooltipFrameArrowColor' },
  { object = self.arrowCenter, colorKey = 'tooltipFrameArrowColor' },
  { object = self.arrowTip, colorKey = 'tooltipFrameArrowColor' },
}
backbone.registerThemeableLabels {
  { object = self.textLabel, colorKey = 'appLogoNameColor' },
}

self:SetScript('OnEnter', setShortcutFrameActivePosition)
self:SetScript('OnLeave', setShortcutFrameInitialPosition)

self:SetScript('OnClick', function()
  self:SetShown(false)
  appFrame:SetShown(true)
end)
