---@type string, Repository
local addon, repository = ...

--[[~ Script: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

local frame = _G.BackboneFrame --[[@as Frame]]

---@type Button
local StartpageButton = _G['BackboneFrameTopMenuPanelStartpageButton']
StartpageButton:HookScript('OnClick', function() repository.setActivePage 'Startpage' end)

---@type Button
local PluginsButton = _G['BackboneFrameTopMenuPanelPluginsButton']
PluginsButton:HookScript('OnClick', function() repository.setActivePage 'Plugins' end)

---@type Button
local SettingsButton = _G['BackboneFrameTopMenuPanelSettingsButton']
SettingsButton:HookScript('OnClick', function() repository.setActivePage 'Settings' end)

---@type Button
local DeveloperToolsButton = _G['BackboneFrameTopMenuPanelDeveloperToolsButton']
DeveloperToolsButton:HookScript('OnClick', function() repository.setActivePage 'DeveloperTools' end)

---@type Button
local CloseButton = _G['BackboneFrameTopMenuPanelCloseButton']
CloseButton:HookScript('OnClick', function() frame:SetShown(false) end)

-- [explain this section]

SettingsButton:HookScript('OnUpdate', function(self)
  if backbone.getEnvironment() == 'production' then
    if DeveloperToolsButton:IsShown() then
      self --[[@as Button]]:SetPoint('TOPRIGHT', CloseButton, 'TOPLEFT', -18, 0)
      DeveloperToolsButton:SetShown(false)
    end
  else
    if not DeveloperToolsButton:IsShown() then
      self --[[@as Button]]:SetPoint('TOPRIGHT', DeveloperToolsButton, 'TOPLEFT', -18, 0)
      DeveloperToolsButton:SetShown(true)
    end
  end
end)
