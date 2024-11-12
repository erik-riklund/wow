--[[~ Command Registration ~
  Updated: 2024/11/12 | Author(s): Erik Riklund (Gopher)
]]

---
--- Registers a command handler, associating it with the
--- specified commands and callback function.
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
