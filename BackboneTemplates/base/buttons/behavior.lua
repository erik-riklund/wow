--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param object BackboneButtonTemplate
---@param colors? BackboneButtonColors
---
BackboneButtonTemplate_OnLoad = function(object, colors)
  colors = colors or {}
  colors.background = colors.background or 'buttonBackgroundColor'
  
  BackboneFrameTemplate_OnLoad(object, colors)
  backbone.widgets.setLocalizedButtonText(object)

  backbone.widgets.onThemeChange(function()
    backbone.widgets.setFontColor( --
      object.textLabel,
      colors.staticTextColor or 'buttonTextColor'
    )
  end)

  object:HookScript('OnEnter', function()
    backbone.widgets.setFontColor( --
      object.textLabel,
      colors.highlightTextColor or 'buttonTextHighlightColor'
    )
  end)

  object:HookScript('OnLeave', function()
    backbone.widgets.setFontColor( --
      object.textLabel,
      colors.staticTextColor or 'buttonTextColor'
    )
  end)
end

---
--- ?
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
--- ?
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
