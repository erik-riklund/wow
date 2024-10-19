local _, app = ...

--[[~ Script: Panel Sets for the Overview Module) ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type app.registerPanelSet
local registerPanelSet = app.registerPanelSet

--
-- ?
--

registerPanelSet('overview', 'startpage', { contentPanel = 'latestNews', sidePanel = 'sidePanel' })
