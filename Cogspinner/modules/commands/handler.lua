--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

---
--- Used to keep track of registered slash commands to prevent conflicts.
---
--- @type table<string, boolean>
---
local registeredCommands = {}

---
--- Responsible for registering slash commands for a specific plugin or context,
--- associating them with a callback function and ensuring no command conflicts occur.
---
--- @type commands.registerHandler
---
local registerCommandHandler = function(context, identifier, commands, callback)
  identifier = string.upper(context.identifier .. '_' .. identifier)

  for index, command in ipairs(commands) do
    if not startsWith(command, '/') then
      command = '/' .. command -- prefix the command with a slash.
    end

    if registeredCommands[command] ~= nil then
      throw('The slash command "%s" is already reserved', command)
    end

    registeredCommands[command] = true -- reserve the command.
    _G['SLASH_' .. identifier .. index] = command
  end

  (SlashCmdList --[[@as table]] )[identifier] = callback
end

--
framework.export('commands/register', registerCommandHandler)
