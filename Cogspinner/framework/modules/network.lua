--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, FrameworkContext
local addon, context       = ...

--#region (locally scoped variables/functions)

local setmetatable         = _G.setmetatable
local throw                = _G.throw
local type                 = _G.type

--#endregion

--#region (framework context imports)

local plugin               = context:import('core/plugin') --[[@as PartialPlugin]]
local tasks                = context:import('module/tasks') --[[@as TaskHandler]]
local list                 = context:import('collection/list') --[[@as ListConstructor]]
local map                  = context:import('collection/map') --[[@as MapConstructor]]

--#endregion

--#region [class: network controller]

--
-- This class manages the core network communication functionality of the framework,
-- providing methods for channel reservation, message transmission, and listener registration.
--

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
  -- Reserves one or more communication channels for the specified plugin owner.
  -- Ensures channel names are unique and initializes listener lists for each channel.
  --

  reserveChannels = function(self, options)
    if type(options.channels) ~= 'table' then
      throw('Invalid argument type for "channels". Expected a table of channel reservation options.')
    end

    local count = #options.channels
    for i = 1, count do
      local channel = options.channels[i]

      if self.channels:has(channel.name) then
        throw('Cannot reserve an occupied channel (%s)', channel.name)
      end

      self.channels:set(
        channel.name,
        {
          owner = options.owner,

          internal = (channel.internal == true)
        }
      )

      self.listeners:set(channel.name, list())
    end
  end,

  --
  -- Registers a listener function to receive messages on a specified channel. Enforces access
  -- control for internal channels and ensures the channel exists before adding the listener.
  --

  registerListener = function(self, options)
    if not self.channels:has(options.channel) then
      throw('Cannot monitor unknown channel (%s)', options.channel)
    end

    local channel = self.channels:get(options.channel) --[[@as NetworkController.Channel]]

    if channel.internal and channel.owner ~= options.reciever then
      throw('Plugin "%s" is not authorized to monitor internal channel "%s"', options.reciever.id, options.channel)
    end

    local listeners = self.listeners:get(options.channel) --[[@as List]]

    listeners:insert(
      {
        id = options.identifier,
        owner = options.reciever,

        callback = options.callback,

      } --[[@as NetworkController.Listener]]
    )
  end,

  --
  -- Removes a listener from a specified channel, ensuring that the channel exists and
  -- the listener belongs to the specified receiver.
  --

  unregisterListener = function(self, options)
    if not self.channels:has(options.channel) then
      throw('Cannot silence listener on unknown channel (%s)', options.channel)
    end

    local listeners = self.listeners:get(options.channel) --[[@as List]]
    local listener_count = listeners:length()

    if listener_count > 0 then
      --#region: Listener removal
      -- Iterate through the listeners to find the one that is targeted for removal.
      --#endregion

      for i = 1, listener_count do
        local listener = listeners:get(i) --[[@as NetworkController.Listener]]

        if listener.owner == options.reciever then
          if listener.identifier == options.identifier then
            listeners:remove(i)

            return -- note: exit early once the listener is found and removed.
          end
        end
      end
    end

    --#note: we throw an exception because the listener wasn't found.
    throw('Listener with ID "%s" not found on channel "%s"', options.identifier, options.channel)
  end,

  --
  -- Transmits a payload (object) on a specified channel. Verifies that the channel exists and
  -- the sender is authorized to transmit on it. If valid, it queues the listener callbacks for
  -- execution with an optional payload.
  --

  transmitPayload = function(self, options)
    if not self.channels:has(options.channel) then
      throw('Cannot transmit on unknown channel (%s)', options.channel)
    end

    local channel = self.channels:get(options.channel) --[[@as NetworkController.Channel]]

    if channel.owner ~= options.sender then
      throw('Plugin "%s" is not authorized to transmit on channel "%s"', options.sender.id, options.channel)
    end

    local listeners = self.listeners:get(options.channel) --[[@as List]]
    local listener_count = listeners:length()

    if listener_count > 0 then
      for i = 1, listener_count do
        local listener = listeners:get(i) --[[@as NetworkController.Listener]]

        tasks:registerTask(
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

--#region [class: network controller API]

--
-- This metatable provides a simplified interface for plugins to interact with the network.
-- It wraps the core functions with methods that include the plugin's context automatically,
-- making them more convenient for plugin use.
--

local NetworkControllerApi =
{
  __index =
  {
    --
    -- Registers a listener for a specified channel on behalf of the plugin. It automatically
    -- includes the plugin's context as the receiver, simplifying the registration process.
    --

    listen = function(self, options)
      NetworkController:registerListener(
        {
          reciever = self.context,
          channel = options.channel,
          callback = options.callback,

          identifier = options.identifier
        }
      )
    end,

    --
    -- Unregisters a listener from a specified channel on behalf of the plugin. Similar to `Listen`,
    -- it automatically includes the plugin's context, streamlining the unregistration process.
    --

    silence = function(self, options)
      NetworkController:unregisterListener(
        {
          reciever = self.context,
          channel = options.channel,
          identifier = options.identifier
        }
      )
    end,

    --
    -- Transmits a payload (object) on a specified channel on behalf of the plugin. It automatically
    -- sets the plugin's context as the sender, making it easier for plugins to interact with the network.
    --

    transmit = function(self, options)
      NetworkController:transmitPayload(
        {
          sender = self.context,
          channel = options.channel,
          payload = options.payload
        }
      )
    end

  } --[[@as NetworkControllerApi]]
}

--#endregion

--
-- Reserves the 'PLUGIN_ADDED' channel for the framework itself. This is an internal channel
-- used to notify other parts of the system when a new plugin is created. The 'internal' flag
-- ensures only the framework can transmit on it.
--

NetworkController:reserveChannels(
  {
    owner = plugin,
    channels = {
      { name = 'PLUGIN_ADDED', internal = true }
    }
  }
)

--
-- Registers a listener within the framework itself to respond to the 'PLUGIN_ADDED' event.
-- When a new plugin is created, this listener sets up its network API and reserves any
-- channels specified in the plugin's options.
--

NetworkController:registerListener(
  {
    reciever = plugin,
    channel = 'PLUGIN_ADDED',

    callback = function(payload)
      --- @cast payload PluginManager.CreationBroadcastPayload

      payload.plugin.network = setmetatable(
        { context = payload.plugin }, NetworkControllerApi
      )

      if payload.options and type(payload.options) == 'table' then
        NetworkController:reserveChannels(
          {
            owner = payload.plugin,
            channels = payload.options.channels
          }
        )
      end
    end
  }
)

--
-- Exports the network controller, making its core functionality available to other modules.
--

context:export('module/network', NetworkController)
