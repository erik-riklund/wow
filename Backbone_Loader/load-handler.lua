---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---A `Vector` object storing registered loading handlers.
context.handlers = new 'Vector'

---@param handler fun(addon_index: number) A function accepting the addon index as a parameter.
---Registers a handler function responsible for a specific loading trigger.
context.registerHandler = function (handler)
  context.handlers:insertElement (handler)
end

---@param addon uiAddon The addon to be loaded.
---Loads the specified addon using the game's addon management system.
context.loadAddon = function (addon)
  C_AddOns.LoadAddOn (addon)
  
  context.plugin:debug ('Loading addon "%s".', C_AddOns.GetAddOnInfo (addon))
end
