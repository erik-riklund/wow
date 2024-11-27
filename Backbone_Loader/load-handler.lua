---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

context.handlers = new 'Dictionary'
context.plugin:createChannel 'PLUGIN_LOADED'

---@param tag string
---@param handler fun(addon_index: number)
---?
context.registerHandler = function (tag, handler)
  context.handlers:setEntry (tag, handler)
end

---@param name string
---?
context.loadAddon = function (name)
  print 'context.loadAddon not implemented'
end
