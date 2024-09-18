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

--- @type network.controller
local network = framework.import('network/controller')

--- @type commands.registerHandler
local registerCommandHandler = framework.import('commands/register')

---
--- The API prototype object providing methods for plugins to register slash command handlers,
--- allowing them to respond to specific commands entered by the user.
---
--- @type commands.api
---
local api = {
  --
  registerCommandHandler = function(self, options)
    local commands = (type(options.command) == 'string' and { options.command }) or (options.command)
    registerCommandHandler(self, options.identifier, commands --[=[@as string[]]=] , options.callback)
  end
}

---
--- This listener is triggered when a new plugin is added to the system.
--- It extends the plugin's capabilities by integrating the command API methods,
--- allowing the plugin to register its own slash command handlers.
---
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  callback = function(plugin)
    integrateTable(plugin, api) -- Inherit the command API method(s).
  end
})
