--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, FrameworkContext
local addon, context       = ...

--#region (locally scoped variables/functions)

local throw                = _G.throw
local type                 = _G.type

--#endregion

--#region (framework context imports)

local plugin               = context:import('core/plugin') --[[@as PartialPlugin]]
local tasks                = context:import('module/tasks') --[[@as TaskHandler]]
local list                 = context:import('collection/list') --[[@as ListConstructor]]
local map                  = context:import('collection/map') --[[@as MapConstructor]]

--#endregion

--#region [class: network manager]

--- @type NetworkController
local NetworkController    =
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

  RegisterListener = function(self, options)
    if not self.channels:Has(options.channel) then
      throw('Cannot monitor unknown channel (%s)', options.channel)
    end

    local channel = self.channels:Get(options.channel) --[[@as Channel]]

    if channel.internal and channel.owner ~= options.reciever then
      throw('Plugin "%s" is not authorized to monitor internal channel "%s"', options.reciever.id, options.channel)
    end

    local listeners = self.listeners:Get(options.channel) --[[@as List]]

    listeners:Insert(
      {
        id = options.identifier,
        owner = options.reciever,

        callback = options.callback,

      } --[[@as Channel.Listener]]
    )
  end,

  --
  -- ?
  --

  UnregisterListener = function(self, options)
    if not self.channels:Has(options.channel) then
      throw('Cannot silence listener on unknown channel (%s)', options.channel)
    end

    local listeners = self.listeners:Get(options.channel) --[[@as List]]
    local listener_count = listeners:Length()

    if listener_count > 0 then
      --#region: Listener removal
      -- Iterate through the listeners to find the one that is targeted for removal.
      --#endregion

      for i = 1, listener_count do
        local listener = listeners:Get(i) --[[@as Channel.Listener]]

        if listener.owner == options.reciever then
          if listener.identifier == options.identifier then
            listeners:Remove(i)

            return -- note: exit early once the listener is found and removed.
          end
        end
      end
    end

    --#note: we throw an exception because the listener wasn't found.
    throw('Listener with ID "%s" not found on channel "%s"', options.identifier, options.channel)
  end,

  --
  -- ?
  --

  TransmitPayload = function(self, options)
    if not self.channels:Has(options.channel) then
      throw('Cannot transmit on unknown channel (%s)', options.channel)
    end

    local channel = self.channels:Get(options.channel) --[[@as Channel]]

    if channel.owner ~= options.sender then
      throw('Plugin "%s" is not authorized to transmit on channel "%s"', options.sender.id, options.channel)
    end

    local listeners = self.listeners:Get(options.channel) --[[@as List]]
    local listener_count = listeners:Length()

    if listener_count > 0 then
      for i = 1, listener_count do
        local listener = listeners:Get(i) --[[@as Channel.Listener]]

        tasks:RegisterTask(
          {
            callback = listener.callback,
            arguments = { options.payload }
          }
        )
      end
    end
  end
}

--#endregion

--#region [class: network API]

local NetworkControllerApi =
{
  __index =
  {

  }
}

--#endregion

--
-- ?
--

NetworkController:ReserveChannels(
  {
    owner = plugin,
    channels = {
      { name = 'PLUGIN_ADDED', internal = true }
    }
  }
)

--
-- ?
--

NetworkController:RegisterListener(
  {
    reciever = plugin,
    channel = 'PLUGIN_ADDED',

    callback = function(payload)
      -- todo: ...
    end
  }
)

--
-- ?
--

context:export('module/network', NetworkController)
