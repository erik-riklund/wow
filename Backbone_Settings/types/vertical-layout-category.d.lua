---@meta
--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class Settings.VerticalLayoutCategory
local category = {}

---@return string name
category.GetName = function (self) end

---@param name string
category.SetName = function (self, name) end

---@return boolean has_parent
category.HasParentCategory = function (self) end

---@return Settings.VerticalLayoutCategory? parent
category.GetParentCategory = function (self) end

---@param parent Settings.VerticalLayoutCategory
category.SetParentCategory = function (self, parent) end

---@param enabled boolean
category.SetShouldSortAlphabetically = function (self, enabled) end
