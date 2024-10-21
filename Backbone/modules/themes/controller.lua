--[[~ Module: Themes ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Theme>
local themes = {}

---@type Theme
local activeTheme

---@type string
local activeThemeName

---
--- Retrieves the RGBA color associated with the given key
--- from the active theme, or `white` if not found.
---
---@param key string
---@return number, number, number, number?
---
backbone.getColor = function(key)
  return unpack(activeTheme[key] or { 1, 1, 1, 1 }) --
end

---
--- Registers a new color theme with the specified name.
---
---@param name string
---@param theme Theme
---
backbone.registerColorTheme = function(name, theme)
  local identifier = string.lower(name)
  if themes[identifier] ~= nil then
    backbone.throwException('Non-unique identifier for theme "%s"', name)
  end

  themes[identifier] = theme
end

---
--- Activates the specified theme and updates all themeable widgets.
---
---@param name string
---
backbone.setActiveColorTheme = function(name)
  local identifier = string.lower(name)
  if themes[identifier] == nil then
    backbone.throwException('Unknown theme "%s"', name)
  end

  activeThemeName = name
  activeTheme = themes[identifier]

  -- TODO: trigger the internal `COLOR_SCHEME_CHANGED` event.
end

---
--- Returns the name of the currently active theme.
---
backbone.getActiveColorTheme = function() return activeThemeName end
