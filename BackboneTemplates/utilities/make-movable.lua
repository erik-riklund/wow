--[[~ Module: Utilities ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param object Frame
---
backbone.widgets.makeMovable = function(object)
  object:RegisterForDrag('LeftButton')

  object:HookScript('OnDragStart', object.StartMoving)
  object:HookScript('OnDragStop', object.StopMovingOrSizing)
end
