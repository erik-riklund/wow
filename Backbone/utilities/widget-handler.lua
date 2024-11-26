
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---
--- ?
---
_G.B_Widget = {}

---
--- ?
---
---@generic T, Tp
---@param frameType `T` | FrameType
---@param name? string
---@param parent? any
---@param template? `Tp` | Template
---@param id? number
---@return table|T|Tp frame
---
B_Widget.createFrame = function (frameType, name, parent, template, id)
  return CreateFrame (frameType, name, parent, template, id)
end
