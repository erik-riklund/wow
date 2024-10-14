--[[~ Module: Theme Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

]]

---@type table<string, Theme>
local themes = {}

---@type Theme
local activeTheme = nil

---@type ThemeableWidget[]
local widgets = {}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

---
--- Retrieves the RGBA color associated with the given key
--- from the active theme, or `white` if not found.
---
---@param key string
---@return number, number, number, number?
backbone.getColor = function(key)
  return unpack(activeTheme[key] or { 1, 1, 1, 1 }) --
end

---
--- Registers a new color theme with the specified name.
---
---@param name string
---@param theme Theme
backbone.registerColorTheme = function(name, theme)
  local identifier = string.lower(name)
  if themes[identifier] ~= nil then
    backbone.throwException('Non-unique identifier for theme "%s"', name)
  end

  themes[identifier] = theme
end

---
--- ?
---
---@param name string
backbone.setActiveColorTheme = function(name)
  local identifier = string.lower(name)
  if themes[identifier] == nil then
    backbone.throwException('Unknown theme "%s"', name)
  end

  activeTheme = themes[identifier]
  backbone.updateThemeableWidgets()
end

---
--- ?
---
---@
backbone.registerThemeableLabels = function()
  print 'backbone.registerThemeableLabels: not implemented.'
end

---
--- ?
---
---@param textures ThemeableTexture[]
backbone.registerThemeableTextures = function(textures)
  for _, texture in ipairs(textures) do
    widgets[#widgets + 1] = {
      object = texture.object,
      method = 'SetColorTexture',
      colorKey = texture.colorKey,
    }
  end
end

---
--- ?
---
---@
backbone.updateThemeableWidgets = function()
  for _, widget in ipairs(widgets) do
    widget.object[widget.method](widget.object, backbone.getColor(widget.colorKey))
  end
end
