--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local throw, type = throw, type
local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type module.tasks
local tasks = context:import('module/tasks')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--#endregion

--
-- This module manages communication channels between plugins, allowing them to
-- reserve, transmit on, and receive messages from specific channels. It ensures
-- that only the owning plugin can transmit on a channel and provides functionality
-- for other plugins to register listeners to receive messages.
--

--- @type module.network
local network_controller =
{
  --
  -- A map to store registered channels and their
  -- metadata (owner, name, internal flag).
  --

  channels = map(),

  --
  -- A map to store listeners associated with each channel.
  --

  listeners = map(),

  --
  -- Reserves one or more channels for a plugin,
  -- ensuring they are not already in use.
  --

  reserve = function(self, owner, channels)
    if type(channels) ~= 'table' then
      throw('Invalid argument type for "channels". Expected a table.')
    end

    local count = #channels
    for i = 1, count do
      --- @type network.reserve.options
      local channel = channels[i]

      if self.channels:has(channel.name) then
        throw('Cannot reserve an occupied channel (%s)', channel.name)
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
  -- Transmits a payload on a specified channel,
  -- ensuring the sender is the channel owner.
  --

  transmit = function(self, sender, channel_name, payload)
    if not self.channels:has(channel_name) then
      throw('Cannot transmit on unknown channel (%s)', channel_name)
    end

    --- @type network.channel
    local channel = self.channels:get(channel_name)

    if channel.owner ~= sender then
      throw('Plugin "%s" is not authorized to transmit on channel "%s"', sender.id, channel_name)
    end

    --- @type list
    local listeners = self.listeners:get(channel.name)
    local listener_count = listeners:length()

    if listener_count > 0 then
      for i = 1, listener_count do
        --- @type network.listener
        local listener = listeners:get(i)

        tasks:register(
          {
            callback = listener.callback,
            arguments = { payload }
          }
        )
      end
    end
  end,

  --
  -- Registers a listener function to receive messages on a specified channel,
  -- ensuring the channel exists and the receiver has permission to use it.
  --

  monitor = function(self, reciever, channel_name, listener)
    if not self.channels:has(channel_name) then
      throw('Cannot monitor unknown channel (%s)', channel_name)
    end

    --- @type network.channel
    local channel = self.channels:get(channel_name)

    if channel.internal and channel.owner ~= reciever then
      throw('Plugin "%s" is not authorized to monitor internal channel "%s"', reciever.id, channel_name)
    end

    --- @type list
    local listeners = self.listeners:get(channel.name)

    listeners:insert(
      {
        id = listener.id,
        owner = reciever,

        callback = listener.callback,

      } --[[@as network.listener]]
    )
  end,

  --
  -- Unregisters a listener from a specified channel.
  --

  silence = function(self, reciever, channel_name, listener_id)
    if not self.channels:has(channel_name) then
      throw('Cannot silence listener on unknown channel (%s)', channel_name)
    end

    --- @type list
    local listeners = self.listeners:get(channel_name)
    local listener_count = listeners:length()

    if listener_count > 0 then
      --#region: Listener removal
      -- Iterate through the listeners to find the one that is targeted for removal.
      --#endregion

      for i = 1, listener_count do
        --- @type network.listener
        local listener = listeners:get(i)

        if listener.owner == reciever then
          if listener.id == listener_id then
            listeners:remove(i)

            return --#note: exit early once the listener is found and removed.
          end
        end
      end
    end

    --#note: we throw an exception because the listener wasn't found.
    throw('Listener with ID "%s" not found on channel "%s"', listener_id, channel_name)
  end
}

--
-- Exports the network controller, making its
-- functionality available to other modules.
--

context:export('module/network', network_controller)
