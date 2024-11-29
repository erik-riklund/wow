
--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class SettingsManager
local manager = {}

---@protected
---@type Plugin
manager.plugin = nil

---@protected
---@type Dictionary
manager.categories = nil

---@param category_name string
---@return SettingsCategory category
---?
manager.getCategory = function (self, category_name)
  if not self.categories:hasEntry (category_name) then
    backbone.throw ('Unknown settings category "%s"', category_name)
  end

  return self.categories:getEntry (category_name)
end

---@param parent? SettingsCategory
---@param category_name string
---?
manager.createCategory = function (self, parent, category_name)
  if self.categories:hasEntry (category_name) then
    backbone.throw ('Duplicate category name "%s"', category_name)
  end

  local object, layout
  if not parent then
    object, layout = Settings.RegisterVerticalLayoutCategory (category_name)
    else object, layout = Settings.RegisterVerticalLayoutSubcategory (parent:getObject(), category_name)
  end

  local category = SettingsCategory (self.plugin, object, layout)
  self.categories:setEntry (category_name, category)

  return category
end

---?
local prototype = { __index = manager }

---@param plugin Plugin
---?
SettingsManager = function (plugin)
  local object = { plugin = plugin, categories = new 'Dictionary' }
  local category, layout = Settings.RegisterVerticalLayoutCategory (string.gsub (plugin:getName(), '_', ' '))

  local category_object = SettingsCategory (plugin, category, layout)
  object.categories:setEntry ('DEFAULT', category_object)

  EventUtil.ContinueOnAddOnLoaded(plugin:getName(),
    function () Settings.RegisterAddOnCategory (category) end
  )

  return setmetatable (object, prototype), category_object
end
