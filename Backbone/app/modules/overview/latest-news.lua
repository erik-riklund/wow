local _, app = ...

--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

local self = _G['BackboneAppOverviewLatestNews'] --[[@as ScrollFrame]]
local registerPanels = app.registerPanels --[[@as app.registerPanels]]

--
-- ?
--
registerPanels('overview', {
  { type = 'CONTENT', identifier = 'latestNews', frameName = 'BackboneAppOverviewLatestNews' },
})
