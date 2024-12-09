---@meta
--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class Settings
Settings = {}

---@class Settings.Default
Settings.Default = { True = true, False = false }

---@class Settings.VarType
Settings.VarType = { Boolean = 'boolean', Number = 'number', String = 'string' }

---@param category Settings.VerticalLayoutCategory
---@param setting table
---@param tooltip? string
---
Settings.CreateCheckbox = function (category, setting, tooltip) end

---@param category Settings.VerticalLayoutCategory
---
Settings.RegisterAddOnCategory = function (category) end

---@param name string
---@return Settings.VerticalLayoutCategory category, Settings.VerticalLayout layout
---
Settings.RegisterVerticalLayoutCategory = function (name) end

---@param parent Settings.VerticalLayoutCategory
---@param name string
---@return Settings.VerticalLayoutCategory category, Settings.VerticalLayout layout
---
Settings.RegisterVerticalLayoutSubcategory = function (parent, name) end

---@generic T
---@param category Settings.VerticalLayoutCategory
---@param variable string
---@param variable_type `T`
---@param name string
---@param default_value T
---@param getter fun(): T
---@param setter fun(value: T)
---@return table setting
---
Settings.RegisterProxySetting = function (category, variable, variable_type, name, default_value, getter, setter) end

---@param text string
---@param tooltip? string
---@return table header
---
CreateSettingsListSectionHeaderInitializer = function (text, tooltip) end
