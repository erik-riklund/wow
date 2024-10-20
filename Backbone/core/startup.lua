local _, app = ...

--[[~ Script: Framework Initialization ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/19

]]

---@type app.activatePanelSet
local activatePanelSet = app.activatePanelSet

--
-- Sets the active color theme to "Backbone", applying it to all themeable elements.
--
backbone.setActiveColorTheme 'Backbone'

--
-- Updates all localized labels with the current locale settings.
--
-- backbone.updateLocalizedLabels()

--
-- Activates the initial panel set for the "overview" module.
--
activatePanelSet('overview', 'startpage')
