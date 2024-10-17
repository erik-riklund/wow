--[[~ Widget: Shortcut Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type ShortcutFrame
local shortcutFrame

---
--- ?
---
---@param self ShortcutFrame
backbone.widgetConstructors.shortcutFrame = function(self)
  shortcutFrame = self -- store the reference for easy access.
  backbone.widgetConstructors.borderedFrame(self) -- parent constructor.

  backbone.registerThemeableTextures {
    { object = self.backgroundColor, colorKey = 'frameBackgroundColor' },
    { object = self.arrowBase, colorKey = 'tooltipFrameArrowColor' },
    { object = self.arrowCenter, colorKey = 'tooltipFrameArrowColor' },
    { object = self.arrowTip, colorKey = 'tooltipFrameArrowColor' },
  }
  backbone.registerThemeableLabels {
    { object = self.textLabel, colorKey = 'logoNameColor' },
  }

  self:SetScript('OnEnter', backbone.widgetControllers.setShortcutFrameActivePosition)
  self:SetScript('OnLeave', backbone.widgetControllers.setShortcutFrameInitialPosition)

  self:SetScript('OnClick', function()
    shortcutFrame:SetShown(false)
    _G['BackboneApp']:SetShown(true)
  end)
end

---
--- ?
---
backbone.widgetControllers.activateShortcutFrame = function()
  backbone.widgetControllers.setShortcutFrameInitialPosition()
  shortcutFrame:SetShown(true)
end

---
--- ?
---
---@
backbone.widgetControllers.setShortcutFrameInitialPosition = function()
  shortcutFrame:SetPoint('BOTTOM', UIParent, 'TOP', 0, -3)
end

---
--- ?
---
---@
backbone.widgetControllers.setShortcutFrameActivePosition = function()
  shortcutFrame:SetPoint('BOTTOM', UIParent, 'TOP', 0, -(shortcutFrame:GetHeight() - 2))
end
