---@class Backbone
local context = select(2, ...)

--[[~ Module: Themes ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Theme>
local themes = {}

---@type Theme
local activeTheme

---@type string
local activeThemeName

---
--- Establishes the network channel used to broadcast when the theme changes.
---
backbone.createChannel 'COLOR_SCHEME_CHANGED'

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
    backbone.throwException('Non-unique identifier for theme "%s"', name) --
  end

  themes[identifier] = theme
end

---
--- Extends an existing color theme with the provided color variables.
---
---@param name string
---@param colors Theme
---
backbone.extendColorTheme = function(name, colors)
  local identifier = string.lower(name)
  if themes[identifier] == nil then
    backbone.throwException('Theme extension failed, unknown theme "%s"', name) --
  end

  backbone.utilities.integrateTable(themes[identifier], colors, false)
end

---
--- Activates the specified theme and updates all themeable widgets.
---
---@param name string
---
backbone.setActiveColorTheme = function(name)
  local identifier = string.lower(name)
  if themes[identifier] == nil then
    backbone.throwException('Unknown theme "%s"', name) --
  end

  activeThemeName = name
  activeTheme = themes[identifier]

  backbone.invokeChannelListeners 'COLOR_SCHEME_CHANGED'
end

---
--- Returns the name of the currently active theme.
---
backbone.getActiveColorTheme = function() return activeThemeName end

---
--- ?
---
---@param color Color
---@param alpha number
---
---@return number[]
---
backbone.setColorAlpha = function(color, alpha)
  return { color[1], color[2], color[3], alpha } --
end

---
--- ?
---
---@param callback function
---
backbone.registerThemeableWidget = function(callback) --
  backbone.registerChannelListener( --
    context.plugin,
    'COLOR_SCHEME_CHANGED',
    { callback = callback }
  )

  callback()
end
