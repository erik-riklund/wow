---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

context.plugin = backbone.createPlugin 'Backbone'

context.plugin:onLoad(function () print 'first' end)
context.plugin:onLoad(function () print 'second' end)
context.plugin:onLoad(function () print 'third' end)
