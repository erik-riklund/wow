---@meta

---@alias app.PanelType 'CONTENT'|'SIDE'

---@alias app.activatePanel fun(module: string, panelType: app.PanelType, identifier: string)
---@alias app.activatePanelSet fun(module: string, identifier: string)
---@alias app.registerPanels fun(module: string, panels: app.registerPanels.Panel[])
---@alias app.registerPanelSet fun(module: string, identifier: string, panels: app.PanelSet)

---
--- ?
---
---@class app.Modules : { [string]: app.Module }

---
--- ?
---
---@class app.Module
---@field panelSets table<string, app.PanelSet>
---@field contentPanels table<string, app.Panel>
---@field sidePanels table<string, app.Panel>

---
--- ?
---
---@class app.registerPanels.Panel
---@field type app.PanelType
---@field identifier string
---@field frameName string
---@field scripts? app.PanelScripts

---
--- ?
---
---@class app.Panel
---@field object Frame
---@field isInitialized boolean
---@field scripts? app.PanelScripts

---
--- ?
---
---@class app.PanelScripts
---@field onActivate? function
---@field onDeactivate? function
---@field onInitialize? function

---
--- ?
---
---@class app.PanelSet
---@field contentPanel string
---@field sidePanel string
