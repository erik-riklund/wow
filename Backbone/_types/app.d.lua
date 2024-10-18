---@meta

---@alias app.Module string
---@alias app.PanelType 'CONTENT'|'SIDE'
---@alias app.PanelRegistry table<string, Frame>

---@alias app.activatePanel fun(module: app.Module, type: app.PanelType, identifier: string)
---@alias app.activatePanelSet fun(module: app.Module, identifier: string)
---@alias app.registerPanels fun(module: app.Module, panels: app.registerPanels.Panel[])
---@alias app.registerPanelSet fun(module: app.Module, contentPanel: string, sidePanel: string)

---@class app.registerPanels.Panel
---@field identifier string
---@field type app.PanelType
---@field panel Frame

---@class app.Panels
---@field sidePanels app.PanelRegistry
---@field contentPanels app.PanelRegistry

---@class app.PanelSet
---@field identifier string

---@class app.ActivePanel
---@field module app.Module
---@field panel Frame
