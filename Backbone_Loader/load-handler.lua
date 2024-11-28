---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---?
context.handlers = new 'Vector'

---@param handler fun(addon_index: number)
---?
context.registerHandler = function (handler)
  context.handlers:insertElement (handler)
end

---@param addon uiAddon
---?
context.loadAddon = function (addon) C_AddOns.LoadAddOn (addon) end
