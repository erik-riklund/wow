---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---@param index number The index of the addon.
---@param key string The metadata key to retrieve.
---@return Vector? metadata A Vector containing the parsed metadata, or `nil` if no metadata exists.
---Retrieves metadata for a specific addon and splits it into a `Vector` if applicable.
context.getAddonMetadata = function (index, key)
  local metadata = C_AddOns.GetAddOnMetadata (index, key)
  return metadata and explode(metadata, ',') or nil
end

---A callback triggered when the plugin loads, registering load-on-demand addons.
context.plugin:onLoad(
  function ()
    local addon_count = C_AddOns.GetNumAddOns()

    for index = 1, addon_count do
      if C_AddOns.IsAddOnLoadOnDemand (index) then
        context.handlers:forEach(function (_, handler) handler(index) end)
      end
    end
  end
)
