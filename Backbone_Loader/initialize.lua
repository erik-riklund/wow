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
    for index = 1, C_AddOns.GetNumAddOns() do
      local name = C_AddOns.GetAddOnInfo(index)
      
      context.tags:forEach(
        ---@param tag string
        function (_, tag)
          local content = C_AddOns.GetAddOnMetadata(name, 'X-Load-' .. tag)
          
          if content then
            context.handlers:getEntry(tag) --[[@as fun(addon: string, content: string)]](name, content)
          end
        end
      )
    end

    context.handlers = nil
    context.tags = nil
  end
)
