local _, context = ...

--[[~ Module: Application Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type table<app.Module, app.Panels>
local modules = {}

---@type table<app.Module, app.PanelSet>
local panelSets = {}

---@type { CONTENT: app.ActivePanel?, SIDE: app.ActivePanel? }
local activePanels = { CONTENT = nil, SIDE = nil }

---
--- ?
---
---@type app.registerPanels
context.registerPanels = function(module, panels)
  print 'context.registerPanels: not implemented.' --
end

---
--- ?
---
---@type app.registerPanelSet
context.registerPanelSet = function(module, contentPanel, sidePanel)
  print 'context.registerPanelSet: not implemented.' --
end

---
--- ?
---
---@type app.activatePanel
context.activatePanel = function(module, type, identifier)
  print 'context.activatePanel: not implemented.' --
end

---
--- ?
---
---@type app.activatePanelSet
context.activatePanelSet = function(module, identifier)
  print 'context.activatePanelSet: not implemented.' --
end
