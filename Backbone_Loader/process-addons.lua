---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

context.plugin:onLoad(
  function ()
    print 'Hello world'
  end
)
