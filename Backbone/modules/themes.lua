--[[~ Module: Theme Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

]]

---@type table<string, Theme>
local themes = {}

---@type Theme
local activeTheme = nil

---
--- Retrieves the RGBA color associated with the given key from the active theme.
--- Returns `white` (1, 1, 1, 1) if the key is not found.
---
---@param key string
---@return number, number, number, number?
backbone.getColor = function(key)
  return unpack(activeTheme[key] or { 1, 1, 1, 1 }) --
end

---
--- ?
---
---@param name string
---@param theme Theme
backbone.registerColorTheme = function(name, theme)
  local identifier = string.lower(name)
  if themes[identifier] ~= nil then
    backbone.throwException('Non-unique identifier for theme "%s"', name)
  end

  themes[identifier] = theme
  activeTheme = activeTheme or theme
end

---
--- ?
---
---@
backbone.registerThemeableWidget = function()
  print 'backbone.registerThemeableWidget: not implemented.'
end

---
--- ?
---
---@
backbone.updateThemeableWidgets = function()
  print 'backbone.updateThemeableWidgets: not implemented.'
end
