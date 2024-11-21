---@meta

---
---@class ScriptRegion : ScriptObject
---
local ScriptRegion = {}

---
--- Returns an anchor point for the region.
---
---@type fun(self: ScriptRegion, anchor_index: ANCHOR_POINT, resolve_collapsed?: boolean): point: AnchorPoint, relative_to: Object, relative_point: AnchorPoint, offset_x: number, offset_y: number
---
ScriptRegion.GetPoint = function(self, anchor_index, resolve_collapsed) end
