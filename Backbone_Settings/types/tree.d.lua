---@meta

--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class SettingsManager.Tree : { [number]: SettingsManager.Header|SettingsManager.CheckBox }

---@class SettingsManager.Header
---@field type 'header'
---@field text string
---@field tooltip? string

---@class SettingsManager.CheckBox
---@field type 'checkbox'
---@field label string
---@field tooltip? string
