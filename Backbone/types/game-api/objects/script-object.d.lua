---@meta

---
---@class ScriptObject : Object
---
local ScriptObject = {}

---
--- Sets the widget script handler. Removes any scripts that were previously hooked with HookScript.
---
---@param script ScriptType
---@param callback function|nil
---
ScriptObject.SetScript = function(self, script, callback) end

---
--- Securely post-hooks a widget script handler. 
---
---@param script ScriptType
---@param callback function
---@param bindingType? number
---
ScriptObject.HookScript = function(self, script, callback, bindingType) end
