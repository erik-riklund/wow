---@meta

---
---@class ScriptObject : Object
---
local ScriptObject = {}

---
--- Sets the widget script handler. Removes any scripts that were previously hooked with HookScript.
---
---@type fun(self: ScriptObject, script: ScriptType, callback: function|nil)
---
ScriptObject.SetScript = function(self, script, callback) end

---
--- Securely post-hooks a widget script handler.
---
---@type fun(self: ScriptObject, script: ScriptType, callback: function, binding_type?: number)
---
ScriptObject.HookScript = function(self, script, callback, binding_type) end
