---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

context.registerHandler (
  function (addon_index)
    local events = context.getAddonMetadata (addon_index, 'X-Load-OnEvent')
    
    if events then
      events:forEach(
        ---@param event_name string
        function (_, event_name)
          context.plugin:registerEventListener(
            event_name, { 
              persistent = false,
              callback = function () context.loadAddon (addon_index) end
            }
          )
        end
      )
    end
  end
)
