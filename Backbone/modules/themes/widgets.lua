--[[~ Module: Themeable Widgets Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/15

]]

---@type ThemeableWidget[]
local themeableWidgets = {}

---
--- Registers a list of labels to be updated when the theme changes.
--- Each label is associated with a color key for setting its text color.
---
---@param labels ThemeableLabel[]
backbone.registerThemeableLabels = function(labels)
  for _, label in ipairs(labels) do
    themeableWidgets[#themeableWidgets + 1] = {
      object = label.object,
      method = 'SetTextColor',
      colorKey = label.colorKey,
    }
  end
end

---
--- Registers a list of textures to be updated when the theme changes.
--- Each texture is associated with a color key for setting its texture color.
---
---@param textures ThemeableTexture[]
backbone.registerThemeableTextures = function(textures)
  for _, texture in ipairs(textures) do
    themeableWidgets[#themeableWidgets + 1] = {
      object = texture.object,
      method = 'SetColorTexture',
      colorKey = texture.colorKey,
    }
  end
end

---
--- Updates all registered themeable widgets by applying the appropriate
--- theme colors  based on the current theme settings.
---
backbone.updateThemeableWidgets = function()
  for _, widget in ipairs(themeableWidgets) do
    backbone.executeCallbackAsync {
      callback = widget.object[widget.method],
      identifier = 'updateThemeableWidget:' .. (widget.object:GetName() or 'ANONYMOUS_WIDGET'),
      arguments = { widget.object, backbone.getColor(widget.colorKey) },
    }
  end
end
