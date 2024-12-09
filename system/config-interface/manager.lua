
--[[~ Updated: 2024/11/29 | Author(s): Gopher ]]

---@class Backbone.ConfigManager
local manager = {}
local prototype = { __index = manager }

---@protected
---@type Backbone.Plugin
manager.plugin = nil

---@protected
---@type Dictionary
manager.categories = nil

---@param category_name string
---@return Backbone.ConfigCategory category
---Returns the configuration options category with the specified name.
---
manager.getCategory = function (self, category_name)
  if not self.categories:hasEntry (category_name) then
    backbone.throw ('Unknown settings category "%s"', category_name)
  end

  return self.categories:getEntry (category_name)
end

---@param parent? Backbone.ConfigCategory
---@param category_name string
---@return Backbone.ConfigCategory
---Creates a new configuration options category.
---
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

---@param plugin Backbone.Plugin
---@return Backbone.ConfigManager, Backbone.ConfigCategory
---Creates a new configuration options manager for the specified plugin.
---
ConfigManager = function (plugin)
  local object = { plugin = plugin, categories = new 'Dictionary' }
  local category, layout = Settings.RegisterVerticalLayoutCategory(
    string.gsub (plugin:getName(), '_', ' ')
  )

  local categoryObject = SettingsCategory (plugin, category, layout)
  object.categories:setEntry ('DEFAULT', categoryObject)

  backbone.onAddonReady(plugin:getName(),
    function () Settings.RegisterAddOnCategory (category) end
  )

  return setmetatable (object, prototype), categoryObject
end
