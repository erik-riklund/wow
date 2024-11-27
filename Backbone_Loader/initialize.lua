---@class Backbone_Loader
local context = select(2, ...)

--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

---?
context.plugin = backbone.createPlugin 'Backbone_Loader'

---?
context.frame = B_Widget.createFrame 'Frame'
