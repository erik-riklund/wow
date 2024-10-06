--[[~ Script: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

local frame = _G.BackboneFrame --[[@as Frame]]

---@type Button
local StartpageButton = _G['BackboneFrameTopMenuPanelStartpageButton']
StartpageButton:HookScript('OnClick', function() print 'Startpage?' end)

---@type Button
local PluginsButton = _G['BackboneFrameTopMenuPanelPluginsButton']
PluginsButton:HookScript('OnClick', function() print 'Plugins?' end)

---@type Button
local SettingsButton = _G['BackboneFrameTopMenuPanelSettingsButton']
SettingsButton:HookScript('OnClick', function() print 'Settings?' end)

---@type Button
local ConsoleButton = _G['BackboneFrameTopMenuPanelConsoleButton']
ConsoleButton:HookScript('OnClick', function() print 'Console?' end)

---@type Button
local CloseButton = _G['BackboneFrameTopMenuPanelCloseButton']
CloseButton:HookScript('OnClick', function() frame:SetShown(false) end)
