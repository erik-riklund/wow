---@meta

---
---@class Frame : ScriptRegion
---
local Frame = {}

---
--- ?
---
---@param event_name EventName
---@return boolean
---
Frame.RegisterEvent = function(self, event_name) end

---
--- Unregisters an event from the frame.
---
---@param event_name EventName
---@return boolean
---
Frame.UnregisterEvent = function(self, event_name) end
