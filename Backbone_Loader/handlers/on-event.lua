---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

---
--- ?
---
context.registerHandler('OnEvent',
  ---@param addon string
  ---@param content string
  function (addon, content)
    local events = new('Vector', { strsplit(', ', content) })

    events:forEach(
      function (index, event_name)
        local identifier = string.format('LOADER/%s/%s', addon, event_name)

        -- why isn't it working? maybe we have to implement a custom loader to deal with dependencies..?
      end
    )
  end
)
