--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
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
  --
  -- Validates the arguments to ensure that the identifier, commands,
  -- and callback are of the correct types. This avoids errors later in
  -- the process by ensuring that each argument conforms to expectations.

  if type(identifier) ~= 'string' then
    throwTypeError('identifier', 'string', type(identifier))
  end

  if type(commands) ~= 'table' then
    throwTypeError('commands', 'table', type(commands))
  end

  if type(callback) ~= 'function' then
    throwTypeError('callback', 'function', type(callback))
  end

  -- Constructs a unique identifier for the command by prefixing it with
  -- the plugin's identifier. This ensures that commands are namespaced to
  -- avoid conflicts between different plugins.

  identifier = string.upper(context.identifier .. '_' .. identifier)

  -- Loops through the list of commands to validate and register each one. It ensures
  -- that the command follows the slash command convention, checks if the command is
  -- already registered, and reserves it if available. Each command is then registered
  -- through a global variable, as that is how the slash command API is designed.

  for index, command in ipairs(commands) do
    if not startsWith(command, '/') then
      command = '/' .. command -- prefix the command with a slash to maintain the correct format.
    end

    if registeredCommands[command] ~= nil then
      throw('The slash command "%s" is already reserved', command) -- ensure no command conflicts exist.
    end

    registeredCommands[command] = true -- reserve the command to prevent further use by other plugins.
    _G['SLASH_' .. identifier .. index] = command
  end

  -- Associates the slash command with the provided callback function,
  -- allowing it to execute the associated logic when the command is invoked.

  (SlashCmdList --[[@as table]] )[identifier] = callback
end

--
framework.export('commands/register', registerCommandHandler)
