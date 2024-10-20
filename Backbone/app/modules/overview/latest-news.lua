local _, app = ...

--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type app.Overview.LatestNewsFrame
local self = _G['BackboneAppOverviewLatestNewsFrame']
local registerPanels = app.registerPanels --[[@as app.registerPanels]]

--
-- ?
--
backbone.registerLocalizedLabels {
  { object = self.headline, labelKey = 'backbone:APP_OVERVIEW_STARTPAGE_HEADLINE' }
}

--
-- ?
--
local newsEntryCount = 1

--
-- ?
--
registerPanels('overview', {
  {
    type = 'CONTENT',
    identifier = 'latestNews',
    frameName = 'BackboneAppOverviewLatestNewsFrame',
    scripts = {
      onInitialize = function()
        --
      end,
    },
  },
})
