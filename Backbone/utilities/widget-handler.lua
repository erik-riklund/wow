
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

--- A utility module for creating UI widgets in the game.
_G.B_Widget = {}

---@generic T, Tp
---@param frameType `T` | FrameType The type of the frame (e.g., "Frame", "Button", "EditBox").
---@param name? string The unique global name of the frame (optional).
---@param parent? any The parent frame to attach this frame to (optional).
---@param template? `Tp` | Template The template to apply to the frame (optional).
---@param id? number A numeric identifier for the frame (optional).
---@return table|T|Tp frame The created frame, which inherits methods and properties of the specified type and template.
---Creates a new frame of the specified type.
B_Widget.createFrame = function (frameType, name, parent, template, id)
  return CreateFrame (frameType, name, parent, template, id)
end
