---@type string, contextProvider
local addon, repository = ...

--[[~ Module: ? ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  ?

  Dependencies: ?

]]

---
--- ?
---
---@type listenable
---
local listenable = {
  ---
  --- ?
  ---
  registerListener = function(self, listener) end,

  ---
  --- ?
  ---
  removeListener = function(self, identifier) end,

  ---
  --- ?
  ---
  invokeListeners = function(self, arguments, options) end,
}

---
--- ?
---
repository.expose('listenable', function()
  return inheritParent({ listeners = {} }, listenable)
end)
