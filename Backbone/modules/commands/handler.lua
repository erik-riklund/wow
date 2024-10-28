--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param handler CommandHandler
---
backbone.registerCommandHandler = function(handler)
  local commands = handler.commands or { handler.command }

  for index, command in ipairs(commands) do
    _G['SLASH_' .. handler.identifier .. index] = '/' .. command
  end

  _G['SlashCmdList'][handler.identifier] = handler.callback
end
