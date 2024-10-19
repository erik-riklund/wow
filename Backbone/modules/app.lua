local _, context = ...

--[[~ Module: Application Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type app.Modules
local modules = {}

---@type { CONTENT: app.Panel?, SIDE: app.Panel? }
local activePanels = { CONTENT = nil, SIDE = nil }

---
--- ?
---
---@type app.registerPanels
context.registerPanels = function(module, panels)
  if modules[module] == nil then
    modules[module] = { panelSets = {}, contentPanels = {}, sidePanels = {} } --
  end

  module = modules[module]
  for _, panel in ipairs(panels) do
    local panelType = (panel.type == 'CONTENT' and 'contentPanels') or 'sidePanels'

    if module[panelType][panel.identifier] ~= nil then
      backbone.throwException('Non-unique identifier for panel "%s" (%s).', panel.identifier, panel.type)
    end

    if type(_G[panel.frameName]) ~= 'table' then
      backbone.throwException('Failed to locate the frame "%s".', panel.frameName)
    end

    module[panelType][panel.identifier] =
      { object = _G[panel.frameName], isInitialized = false, scripts = panel.scripts } --[[@as app.Panel]]
  end
end

---
--- ?
---
---@type app.registerPanelSet
context.registerPanelSet = function(module, identifier, panels)
  if modules[module] == nil then
    backbone.throwException('The module "%s" has no registered panels.', module)
  end

  if modules[module].panelSets[identifier] ~= nil then
    backbone.throwException('Duplicate entry for panel set "%s" (%s).', identifier, module)
  end

  if modules[module].contentPanels[panels.contentPanel] == nil then
    backbone.throwException('Unknown content panel "%s" (%s).', panels.contentPanel, module)
  end

  if modules[module].sidePanels[panels.sidePanel] == nil then
    backbone.throwException('Unknown side panel "%s" (%s).', panels.sidePanel, module)
  end

  modules[module].panelSets[identifier] = panels
end

---
--- ?
---
---@type app.activatePanel
context.activatePanel = function(module, panelType, identifier)
  if modules[module] == nil then
    backbone.throwException('The module "%s" has no registered panels.', module)
  end

  local registry = (panelType == 'CONTENT' and 'contentPanels') or 'sidePanels'

  if modules[module][registry][identifier] == nil then
    backbone.throwException('Unknown %s panel "%s" (%s).', panelType, identifier, module)
  end

  local panel = modules[module][registry][identifier] --[[@as app.Panel]]
  local activePanel = activePanels[panelType] --[[@as app.Panel?]]

  if activePanel ~= nil and activePanel.object ~= panel.object then
    if activePanel.scripts and activePanel.scripts.onDeactivate then
      backbone.executeCallback {
        identifier = 'app.deactivatePanel:' .. identifier,
        callback = activePanel.scripts.onDeactivate,
      }
    end

    activePanel.object:SetShown(false)
    activePanels[panelType] = nil
  end

  if not panel.isInitialized then
    if panel.scripts and panel.scripts.onInitialize then
      backbone.executeCallback {
        identifier = 'app.initializePanel:' .. identifier,
        callback = panel.scripts.onInitialize,
      }
    end

    panel.isInitialized = true
  end

  if not panel.object:IsShown() then
    activePanels[panelType] = panel
    panel.object:SetShown(true)
  end
end

---
--- ?
---
---@type app.activatePanelSet
context.activatePanelSet = function(module, identifier)
  if modules[module] == nil then
    backbone.throwException('The module "%s" has no registered panels.', module)
  end

  if modules[module].panelSets[identifier] == nil then
    backbone.throwException('Unknown panel set "%s" (%s).', identifier, module)
  end

  local panelSet = modules[module].panelSets[identifier]

  context.activatePanel(module, 'SIDE', panelSet.sidePanel)
  context.activatePanel(module, 'CONTENT', panelSet.contentPanel)
end
