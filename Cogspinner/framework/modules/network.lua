--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, FrameworkContext
local addon, context = ...

--#region (locally scoped variables/functions)

local throw          = _G.throw
local type           = _G.type

--#endregion

--#region (framework context imports)

local tasks          = context:import('module/tasks') --[[@as TaskHandler]]
local list           = context:import('collection/list') --[[@as ListConstructor]]
local map            = context:import('collection/map') --[[@as MapConstructor]]

--#endregion

--#region [class: network manager]

--- @type NetworkController
local Controller     =
{
  --
  -- A map to store registered channels and their metadata.
  --

  channels = map(),

  --
  -- A map to store listeners associated with each channel.
  --

  listeners = map(),

  --
  -- ?
  --

  ReserveChannels = function(self, options)
    if type(options.channels) ~= 'table' then
      throw('?')
    end

    local count = #options.channels
    for i = 1, count do
      local channel = options.channels[i]

      if self.channels:Has(channel.name) then
        throw('Cannot reserve an occupied channel (%s)', channel.name)
      end

      self.channels:Set(
        channel.name,
        {
          owner = options.owner,

          internal = (channel.internal == true)
        }
      )

      self.listeners:Set(channel.name, list())
    end
  end,

  --
  -- ?
  --

  RegisterListener = function(self, options) end,

  --
  -- ?
  --

  UnregisterListener = function(self, options) end,

  --
  -- ?
  --

  TransmitPayload = function(self, options) end
}

--#endregion

--#region [class: network API]

local API            =
{
  __index =
  {

  }
}

--#endregion

--
-- ?
--

context:export('module/network', Controller)
