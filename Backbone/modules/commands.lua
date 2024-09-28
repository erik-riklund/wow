---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'plugin-api' --[[@as plugin]]

--[[~ Module: Command Registration ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  This module handles the registration of commands for plugins. It ensures that commands 
  are uniquely registered and linked to the appropriate callback functions for handling 
  user input.

  Features:

  - Register commands and associate them with callbacks.
  - Support both single and multiple command aliases.
  - Ensure unique command registration to prevent conflicts.

]]

---@type table<string, string>
local registeredCommands = {}

---
--- registerCommand()
---
--- This function registers a command (or multiple commands) for a plugin, associating them with
--- a callback function. Commands can be provided as a single string or an array of strings, which
--- are normalized to lowercase. If a command is already registered, an error is thrown.
---

plugin.registerCommand = function(self, identifier, commands, callback)
  xtype.validate {
    { 'identifier:string', identifier },
    { 'commands:string/array', commands },
    { 'callback:function', callback },
  }

  if type(commands) == 'string' then
    commands = { commands } -- Convert a single command to an array.
  end

  identifier = string.upper(identifier) -- normalize to uppercase.

  -- Loop through each command and ensure it is not already registered. If a command is
  -- found in the `registeredCommands` table, an error is thrown to prevent conflicts.

  for index, command in ipairs(commands) do
    command = string.lower(command) -- normalize to lowercase.

    if registeredCommands[command] ~= nil then
      throw(
        'Command "%s" is already registered by plugin %s.',
        command,
        registeredCommands[command]
      )
    end

    -- Generate the global variable name for the command,
    -- based on the plugin identifier and command index.

    local variable = 'SLASH_' .. identifier .. index

    if _G[variable] ~= nil then
      throw(
        'Global variable "%s" for command group "%s" is already in use.',
        variable,
        identifier
      )
    end

    -- Register the command in the `registeredCommands` table and set the global variable
    -- with the slash command to ensure it can be invoked by the user.

    registeredCommands[command] = self.identifier
    _G[variable] = '/' .. command -- set the slash command.
  end

  -- Ensure the callback registry for the command identifier is not already occupied. If the
  -- `SlashCmdList` entry for the identifier is in use, an error is thrown. Otherwise, the
  -- callback is registered.

  local registry = _G.SlashCmdList --[[@as table]]

  if registry[identifier] ~= nil then
    throw('Failed to register slash command group "%s" (non-unique identifier).', identifier)
  end

  registry[identifier] = callback
end
