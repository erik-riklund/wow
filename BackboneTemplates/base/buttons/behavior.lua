--[[~ Module: Template / Buttons ~
  Updated: 2024/11/05 | Author(s): Erik Riklund (Gopher)
]]

---
--- The constructor for the generic button template.
---
---@param object BackboneButtonTemplate
---@param colors? BackboneButtonColors
---
BackboneButtonTemplate_OnLoad = function(object, colors)
  colors = colors or {}
  colors.background = colors.background or 'buttonBackgroundColor'

  backbone.widgets.setLocalizedButtonText(object)
  BackboneFrameTemplate_OnLoad(object, colors) -- parent constructor.

  backbone.widgets.onThemeChange(function()
    local color = colors.staticTextColor or 'buttonTextColor'
    backbone.widgets.setFontColor(object.textLabel, color)
  end)

  object:HookScript('OnEnter', function()
    local color = colors.highlightTextColor or 'buttonTextHighlightColor'
    backbone.widgets.setFontColor(object.textLabel, color)
  end)

  object:HookScript('OnLeave', function()
    local color = colors.staticTextColor or 'buttonTextColor'
    backbone.widgets.setFontColor(object.textLabel, color)
  end)
end

---
--- Sets the text of the provided button object based on the specified localized string key.
---
---@param object BackboneButtonTemplate
---@param textKey? string
---
backbone.widgets.setLocalizedButtonText = function(object, textKey)
  local namespace, key = string.split(':', textKey or object.textLabel:GetText(), 2)
  object.textLabel:SetText(backbone.getLocalizedString(namespace, key))

  backbone.widgets.setButtonWidth(object) -- updates the width to match the text content.
end

---
--- Sets the width of the provided button object based on its current
--- text label (if the width is not explicitly specified).
---
---@param object BackboneButtonTemplate
---@param width? number
---@param padding? number
---
backbone.widgets.setButtonWidth = function(object, width, padding)
  object:SetWidth(backbone.utilities.adjustToEven( --
    (width or object.textLabel:GetStringWidth()) + ((padding or 10) * 2)
  ))
end
