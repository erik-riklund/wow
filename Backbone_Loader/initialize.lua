---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

---
--- ?
---
context.tags = new 'Vector'

---
--- ?
---
context.handlers = new 'Dictionary'

---
--- ?
---
context.plugin = backbone.createPlugin 'Backbone_Loader'

---
--- ?
---
---@param tag string
---@param handler fun(addon: string, content: string)
---
context.registerHandler = function (tag, handler)
  context.tags:insertElement (tag)
  context.handlers:setEntry (tag, handler)
end

---
--- ?
---
context.plugin:onLoad(
  function ()
    
  end
)
