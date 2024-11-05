--[[~ Module: Widgets / Utilities ~
  Updated: 2024/11/05 | Author(s): Erik Riklund (Gopher)
]]

---
--- Enables movability for the provided frame object.
---
---@param object Frame
---
backbone.widgets.makeMovable = function(object)
  object:RegisterForDrag('LeftButton')

  object:HookScript('OnDragStart', object.StartMoving)
  object:HookScript('OnDragStop', object.StopMovingOrSizing)
end
