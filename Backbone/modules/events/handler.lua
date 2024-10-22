--[[~ Module: Events ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Event>
local events = {}
local sharedFrame = backbone.getSharedFrame()

---
--- ?
---


---
--- ?
---
backbone.registerEventListener = function() end

---
--- ?
---
backbone.removeEventListener = function() end

---
--- ?
---
sharedFrame:RegisterEvent 'ADDON_LOADED'

---
--- ?
---
sharedFrame:HookScript(
  'OnEvent',
  ---@param eventName string
  function(_, eventName, ...) end
)
