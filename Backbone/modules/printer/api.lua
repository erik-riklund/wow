---@class Backbone
local context = select(2, ...)

--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@class PrinterApi
---
local api = {
  ---
  --- ?
  ---
  ---@param self Plugin
  ---@param type BroadcastType
  ---@param message string
  ---
  ---@param ... string|number
  ---
  broadcast = function(self, type, message, ...)
    backbone.broadcast(type, self.name, message, ...) --
  end,
}

---
--- Integrates the printer API into new plugins.
---
context.apis[#context.apis + 1] = function(plugin)
  backbone.utilities.integrateTable(plugin, api) --
end
