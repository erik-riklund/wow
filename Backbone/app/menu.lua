local _, app = ...

--[[~ Script: Application Menu ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/19

]]

local appFrame = _G['BackboneApp']
local activatePanelSet = app.activatePanelSet --[[@as app.activatePanelSet]]

--
-- ?
--
local overviewButton = appFrame.overviewButton --[[@as Button]]
local settingsButton = appFrame.settingsButton --[[@as Button]]
local pluginsButton = appFrame.pluginsButton --[[@as Button]]
local themesButton = appFrame.themesButton --[[@as Button]]
local consoleButton = appFrame.consoleButton --[[@as Button]]
local unitTestsButton = appFrame.unitTestsButton --[[@as Button]]

--
-- ?
--
local setUnitTestsButtonState = function()
  unitTestsButton:SetShown(backbone.getEnvironment() == 'development')
end

--
-- ?
--
unitTestsButton:HookScript('OnLoad', setUnitTestsButtonState)
unitTestsButton:HookScript('OnShow', setUnitTestsButtonState)

--
-- ?
--
-- TODO: add listener for the internal `ENVIRONMENT_CHANGED` event.

--
-- ?
--
overviewButton:HookScript('OnClick', function() print 'Hello world' end)
settingsButton:HookScript('OnClick', function() print 'Hello world' end)
pluginsButton:HookScript('OnClick', function() print 'Hello world' end)
themesButton:HookScript('OnClick', function() print 'Hello world' end)
consoleButton:HookScript('OnClick', function() activatePanelSet('console', 'overview') end)
unitTestsButton:HookScript('OnClick', function() print 'Hello world' end)
