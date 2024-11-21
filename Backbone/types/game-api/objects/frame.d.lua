---@meta

---
---@class Frame : ScriptRegion
---
local Frame = {}

---
--- ?
---
---@type fun(self: Frame, event_name: EventName): registered: boolean
---
Frame.RegisterEvent = function(self, event_name) end

---
--- Unregisters an event from the frame.
---
---@type fun(self: Frame, event_name: EventName): unregistered: boolean
---
Frame.UnregisterEvent = function(self, event_name) end
