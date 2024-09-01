--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, FrameworkContext
local addon, context = ...

--#region (locally scoped variables/functions)

local setmetatable   = _G.setmetatable
local string         = _G.string
local throw          = _G.throw

--#endregion

--#region (framework context imports)

local framework      = context:import('core/plugin') --[[@as PartialPlugin]]
local network        = context:import('module/network') --[[@as NetworkController]]
local map            = context:import('collection/map') --[[@as MapConstructor]]

--#endregion

--#region [class: plugin manager]

--
-- ?
--

--- @type PluginManager
local PluginManager  =
{
  --
  -- ?
  --

  plugins = map(),

  --
  -- ?
  --

  createPlugin = function(self, options)
    local identifier = self.normalizeIdentifier(options.identifier)

    if self.plugins:has(identifier) then
      throw('?')
    end

    local newPluginContext = { id = identifier } --[[@as PartialPlugin]]
    self.plugins:set(identifier, newPluginContext)

    network:transmitPayload(
      {
        sender = framework,
        channel = 'PLUGIN_ADDED',

        payload = { plugin = newPluginContext, options = options }
      }
    )

    return newPluginContext
  end,

  --
  -- ?
  --

  normalizeIdentifier = function(identifier)
    return string.lower(identifier)
  end
}

--#endregion

--#region [class: plugin API]

--
-- ?
--

local PluginApi      =
{
  __index =
  {
    --
    -- ?
    --

    OnLoad = function(self, callback)
      -- todo: implement when the event handler is done.
    end

  } --[[@as PartialPlugin]]
}

--#endregion

--
-- ?
--

network:registerListener(
  {
    reciever = framework,
    channel = 'PLUGIN_ADDED',

    callback = function(payload)
      --- @cast payload PluginManager.CreationBroadcastPayload

      setmetatable(payload.plugin, PluginApi)
    end
  }
)

--
-- ?
--

context:export('module/plugins', PluginManager)
