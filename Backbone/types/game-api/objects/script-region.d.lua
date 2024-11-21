---@meta

---
---@class ScriptRegion : ScriptObject
---
local ScriptRegion = {}

---
--- Removes all anchor points from the region.
---
---@type fun(self: ScriptRegion)
---
ScriptRegion.ClearAllPoints = function(self) end

---
--- Returns an anchor point for the region.
---
---@type fun(self: ScriptRegion, anchor_index: ANCHOR_POINT, resolve_collapsed?: boolean): point: AnchorPoint, relative_to: Object, relative_point: AnchorPoint, offset_x: number, offset_y: number
---
ScriptRegion.GetPoint = function(self, anchor_index, resolve_collapsed) end

---
--- ?
---
---@type fun(self: ScriptRegion, point: AnchorPoint, relative_to?: string|ScriptRegion, relative_point?: AnchorPoint, offset_x?: number, offset_y?: number)
---
ScriptRegion.SetPoint = function(self, point, relative_to, relative_point, offset_x, offset_y) end
