---@meta
--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class Settings
Settings = {}

---@class Settings.Default
Settings.Default = { True = true, False = false }

---@class Settings.VarType
Settings.VarType = { Boolean = 'boolean', Number = 'number', String = 'string' }

---@param category Settings.VerticalLayoutCategory
Settings.RegisterAddOnCategory = function (category) end

---@param name string
---@return Settings.VerticalLayoutCategory category, table layout
Settings.RegisterVerticalLayoutCategory = function (name) end

---@param parent Settings.VerticalLayoutCategory
---@param name string
---@return Settings.VerticalLayoutCategory category, table layout
Settings.RegisterVerticalLayoutSubcategory = function (parent, name) end

---@
Settings.RegisterAddOnSetting = function () end
