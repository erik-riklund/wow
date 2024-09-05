--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework     = ...

local exception            = _G.exception
local type                 = _G.type

local createRecord         = framework.import('collection/record') --[[@as RecordConstructor]]
local createImmutableProxy = framework.import('table/immutable') --[[@as ImmutableTableProxy]]
local network              = framework.import('module/network') --[[@as Network]]

--
-- A record to store registered plugins, ensuring uniqueness and efficient lookup by name.
--
local plugins              = createRecord()

--
-- Factory function that creates and registers new plugin contexts within the framework.
--
--- @type PluginConstructor
--
local createPlugin         = function(name, options)
  --~ Input validation and error handling:
  --~ We ensure that the provided options are valid and the plugin name is unique
  --~ to avoid unexpected behavior and potential conflicts during plugin creation.

  if options and type(options) ~= 'table' then
    exception('Invalid argument type for "options". Expected a table containing plugin configuration.')
  end

  if type(name) ~= 'string' then
    exception('Invalid plugin name, must be a string.')
  end

  if plugins:entryExists(name) then
    exception('Plugin registration failed: A plugin with the name "%s" already exists.', name)
  end

  --~ ?

  local pluginContext = { name = name }
  plugins:set(name, pluginContext)

  network.triggerChannel('PLUGIN_ADDED', { pluginContext, options })

  --~ We return the plugin context wrapped in an immutable
  --~ proxy to prevent accidental modification.

  return createImmutableProxy(pluginContext)
end

--
-- Exports the `createPlugin` function, making it the primary interface for creating
-- new plugins within the framework.
--
framework.export('module/plugin', createPlugin)
