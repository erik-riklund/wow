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
  return metadata and explode(metadata, ',') or nil
end

---?
context.plugin:onLoad(
  function ()
    local addon_count = C_AddOns.GetNumAddOns()
    for index = 1, addon_count do
      ---@class AddonState
      local addon = { loadable = C_AddOns.IsAddOnLoadOnDemand (index) }

      if addon.loadable then
        addon.dependencies = context.getAddonMetadata (index, 'X-Dependencies')
        context.handlers:forEach(function (_, handler) handler(index) end)  
      end

      addon.name = C_AddOns.GetAddOnInfo (index)
      addon.loaded = select (2, C_AddOns.IsAddOnLoaded (index)) --[[@as boolean]]
      context.addons:setEntry (addon.name, addon)
    end

    --DevTools_Dump (context.addons)
  end
)
