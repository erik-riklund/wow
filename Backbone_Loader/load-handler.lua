---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

---?
context.handlers = new 'Vector'
local addons_loading = new 'Vector'

---@param handler fun(addon_index: number)
---?
context.registerHandler = function (handler) context.handlers:insertElement (handler) end

---@param identifier uiAddon
---?
context.loadAddon = function (identifier)
  local addon_name = C_AddOns.GetAddOnInfo (identifier)
  
  if not addons_loading:contains (addon_name) then
    local addon = context.addons:getEntry (addon_name) --[[@as AddonState]]

    if addon.dependencies then
      for _, dependency_name in addon.dependencies:getIterator() do
        if not addons_loading:contains (dependency_name) then
          local dependency = context.addons:getEntry (dependency_name) --[[@as AddonState]]
  
          if not dependency or not (dependency.loaded or dependency.loadable) then
            return print(string.format(
              'Backbone_Loader: Missing dependency "%s" for addon (%s).', dependency_name, addon_name
            ))
          end
          
          if not dependency.loaded then context.loadAddon (dependency_name) end
        end
      end
    end

    addons_loading:insertElement (addon_name)
  end
end

context.frame:HookScript(
  'OnUpdate', function ()
    local load_count = addons_loading:getSize()
      
    if load_count > 0 then
      -- TODO: implement the actual loader logic!
    end
  end
)
