---@type string, contextProvider
local addon, repository = ...

--[[~ Component: Storage Unit ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  ?

  Dependencies: ?

]]

---@type storage.unit
local unit = {
  ---
  ---
  ---
  getEntry = function(self, path) end,

  ---
  ---
  ---
  setEntry = function(self, path, value) end,
}

---
---
---
---@type storage.unitConstructor
---
local constructor = function(variable)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
repository.expose('storage-unit', constructor)
