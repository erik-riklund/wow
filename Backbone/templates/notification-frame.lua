--[[~ Template: Notification Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---
--- ?
---
---@param self NotificationFrameTemplate
---@param options? NotificationFrameTemplateOptions
backbone.widgetConstructors.notificationFrame = function(self, options)
  options = options or {}
  local colorKeys = options.colorKeys or {}

  backbone.widgetConstructors.borderedFrame(self, options.colorKeys) -- parent constructor.

  backbone.registerThemeableTextures {
    {
      object = self.backgroundColor,
      colorKey = colorKeys.backgroundColor or 'frameBackgroundColor',
    },
  }

  backbone.registerThemeableLabels {
    { object = self.dismissLabel, colorKey = colorKeys.dismissLabelColor },
    { object = self.contentLabel, colorKey = colorKeys.textColor },
  }
  backbone.registerLocalizedLabels {
    { object = self.dismissLabel, labelKey = self.dismissLabel:GetText() },
  }

  self:HookScript('OnShow', function()
    self.lastHovered = GetTime()
    backbone.widgetControllers.updateNotificationFrameDimensions(self)
  end)

  self:HookScript('OnEnter', function() self.isHovering = true end)

  self:HookScript('OnLeave', function()
    self.isHovering = false
    self.lastHovered = GetTime()
  end)

  self:HookScript('OnMouseUp', function(_, button)
    if button == 'RightButton' then self:SetShown(false) end
  end)

  self:HookScript(
    'OnUpdate',
    function()
      self:SetShown(
        self.isHovering or (GetTime() - self.lastHovered <= (options.closeDelay or 3600.0))
      )
    end
  )
end

---
--- ?
---
---@param self NotificationFrameTemplate
---@param lines string[]
backbone.widgetControllers.setNotificationFrameContent = function(self, lines)
  self.contentLabel:SetText(table.concat(lines, '\n'))
end

---
--- ?
---
---@param self NotificationFrameTemplate
backbone.widgetControllers.updateNotificationFrameDimensions = function(self)
  local makeNumberEven = backbone.utilities.makeNumberEven

  local horizontalPadding = 48
  local verticalPadding = makeNumberEven(math.ceil(self.dismissLabel:GetStringHeight())) + 24

  local minimumWidth = makeNumberEven(math.ceil(self.dismissLabel:GetStringWidth()))
  local contentWidth = makeNumberEven(math.ceil(self.contentLabel:GetStringWidth()))
  local contentHeight = makeNumberEven(math.ceil(self.contentLabel:GetStringHeight()))

  self:SetSize(
    ((contentWidth > minimumWidth and contentWidth) or minimumWidth) + horizontalPadding,
    contentHeight + verticalPadding
  )
end
