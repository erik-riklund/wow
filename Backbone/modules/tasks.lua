---@class Backbone
local context = select(2, ...)

--[[~ Task manager (module) ~
  Updated: 2024/11/19 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local queued_tasks = new 'Vector'

---
--- ?
---
---@param task Task
---
backbone.executeTask = function(task)
  print 'backbone.executeTask: not implemented.' --
end

---
--- ?
---
---@param task Task
---
backbone.executeTaskAsync = function(task)
  print 'backbone.executeTaskAsync: not implemented.' --
end
