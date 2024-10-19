local _, app = ...

--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

local self = _G['BackboneAppOverviewSidePanel'] --[[@as Frame]]
local registerPanels = app.registerPanels --[[@as app.registerPanels]]

--
-- ?
--
registerPanels('overview', {
  { type = 'SIDE', identifier = 'sidePanel', frameName = 'BackboneAppOverviewSidePanel' },
})
