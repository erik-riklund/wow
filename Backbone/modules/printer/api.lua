---@class Backbone
local context = select(2, ...)

--[[~ Printer API Integration ~
  Updated: 2024/11/12 | Author(s): Erik Riklund (Gopher)
]]

---
--- A simple API for broadcasting messages from plugins,
--- allowing message dispatch across different types.
---
---@class PrinterApi
---
local api = {
  ---
    --- Broadcasts a message from the plugin to a specified broadcast type (e.g., channel or group).
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
