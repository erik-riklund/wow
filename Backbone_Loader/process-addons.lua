---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

context.addons = new 'Dictionary'

---@param index number
---@param key string
---@return Vector?
---?
context.getAddonMetadata = function (index, key)
  local metadata = C_AddOns.GetAddOnMetadata (index, key)
  return metadata and explode(metadata, ', ') or nil
end

---?
context.plugin:onLoad(
  function ()
    local addon_count = C_AddOns.GetNumAddOns ()
    
    for index = 1, addon_count do
      if C_AddOns.IsAddOnLoadOnDemand (index) then
        ---@class AddonState
        local addon = {}

        addon.dependencies = context.getAddonMetadata (index, 'X-Dependencies')
        addon.optional_dependencies = context.getAddonMetadata (index, 'X-Dependencies?')
        addon.loaded = select (2, C_AddOns.IsAddOnLoaded (index)) --[[@as boolean]]

        context.handlers:forEach(function (_, handler) handler(index) end)
        context.addons:setEntry (C_AddOns.GetAddOnInfo (index), addon)
      end
    end
  end
)
