--[[~ Module: Printer ~
  Updated: 2024/11/11 | Author(s): Erik Riklund (Gopher)
]]

---
--- Broadcasts a formatted message to the chat.
---
---@param type BroadcastType
---@param sender? string
---@param message string
---
---@param ... string|number
---
backbone.broadcast = function(type, sender, message, ...)
  type = string.lower(type)

  local output = (... and string.format(message, ...)) or message
  print(backbone.markup.colorize(string.format('<%s>%s (%s)</%s>', type, output, sender, type)))
end
