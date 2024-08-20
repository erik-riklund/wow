--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type module.tasks
local tasks = context:import('module/tasks')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--#endregion

--#region (locally scoped variables)

local throw = throw
local type = type

--#endregion

--
-- ?
--

--- @type module.network
local network_controller =
{
  --
  -- ?
  --

  channels = map(),

  --
  -- ?
  --

  listeners = map(),

  --
  -- ?
  --

  reserve = function(self, owner, channels)
    if type(channels) ~= 'table' then
      throw('?')
    end

    local count = #channels
    for i = 1, count do
      local channel = channels[i] --[[@as network.reserve.options]]

      if self.channels:has(channel.name) then
        throw('?')
      end

      self.channels:set(
        channel.name,
        {
          owner = owner,
          name = channel.name,

          internal = channel.internal

        } --[[@as network.channel]]
      )

      self.listeners:set(channel.name, list())
    end
  end,

  --
  -- ?
  --

  transmit = function(self, sender, channel_name, payload)
    --#todo: implement triggering using the task module!
  end,

  --
  -- ?
  --

  monitor = function(self, reciever, channel_name, listener)
    if not self.channels:has(channel_name) then
      throw('?')
    end

    --- @type network.channel
    local channel = self.channels:get(channel_name)

    if channel.internal and channel.owner ~= reciever then
      throw('?')
    end

    --- @type utility.collection.list.object
    local listeners = self.listeners:get(channel_name)

    listeners:insert(
      {
        id = listener.id,
        owner = reciever,
        
        callback = listener.callback,

      } --[[@as network.listener]]
    )
  end,

  --
  -- ?
  --

  silence = function(self, reciever, channel_name, listener_id)
    if not self.channels:has(channel_name) then
      throw('?')
    end

    --#todo: implementation!
  end
}

--
-- ?
--

context:export('module/network', network_controller)
