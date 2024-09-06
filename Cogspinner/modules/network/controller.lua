--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework      = ...
local exception             = _G.exception
local type                  = _G.type

local createListenerManager = framework.import('shared/listeners') --[[@as ListenerManagerConstructor]]
local createRecord          = framework.import('collection/record') --[[@as RecordConstructor]]
local mergeTables           = framework.import('table/merge') --[[@as TableMerger]]

--
-- Manages communication channels and their listeners, allowing
-- for controlled message broadcasting and subscription.
--
local channels              = createRecord()

--
-- Factory function for creating a new communication channel.
--
--- @param name string The unique name of the channel.
--- @param options ChannelOptions Configuration options for the channel.
--
local createChannel         = function(name, options)
  return mergeTables(createListenerManager(), { name = name }, options)
end

--
-- Acts as a central controller for network communication, handling channel
-- reservation, listener registration, and message transmission.
--
--- @type Network
--
local controller            =
{
  --
  -- Reserves a unique channel and initializes its listener list.
  --
  reserveChannel = function(name, options, context)
    --~ Validate input arguments to ensure they are of the
    --~ correct type to prevent potential errors.

    if type(name) ~= 'string' then
      exception('Invalid channel name. Expected a string.')
    end

    if options and type(options) ~= 'table' then
      exception('Invalid channel options. Expected a table or nil.')
    end

    if context and type(context) ~= 'string' then
      exception('Invalid context. Expected a string representing a plugin.')
    end

    if channels:entryExists(name) then
      exception('Channel reservation failed, "%s" already exists.', name)
    end

    --~ If validation passes, create and store the channel.

    channels:set(name, createChannel(name, mergeTables(options, { owner = context })))
  end,

  --
  -- Registers a listener to a specific channel, enforcing
  -- access control for internal channels.
  --
  registerListener = function(channel, listener, context)
    --~ Validate input arguments to ensure they are of the
    --~ correct type to prevent potential errors.

    if type(channel) ~= 'string' then
      exception('Invalid channel name. Expected a string.')
    end

    if type(listener) ~= 'table' then
      exception('Invalid listener. Expected a table representing a listener object.')
    end

    if context and type(context) ~= 'string' then
      exception('Invalid context. Expected a string representing a plugin.')
    end

    if not channels:entryExists(channel) then
      exception('Listener registration failed, the channel "%s" does not exist.', channel)
    end

    --~ Retrieve the channel and verify access rights before registering the listener.

    channel = channels:get(channel) --[[@as Channel]]

    if channel.internal and channel.owner ~= context then
      exception('Listener registration failed, the channel "%s" is protected.', channel.name)
    end

    channel:registerListener(
      mergeTables(listener, { owner = context }) --[[@as NetworkListener]]
    )
  end,

  --
  -- Removes a listener from a channel, ensuring the listener exists
  -- and the caller has permission to remove it.
  --
  removeListener = function(channel, identifier, context)
    --~ Validate input arguments to ensure they are of the
    --~ correct type to prevent potential errors.

    if type(channel) ~= 'string' then
      exception('Invalid channel name. Expected a string.')
    end

    if type(identifier) ~= 'string' then
      exception('Invalid listener identifier. Expected a string.')
    end

    if context and type(context) ~= 'string' then
      exception('Invalid context. Expected a string representing a plugin.')
    end

    if not channels:entryExists(channel) then
      exception('Listener removal failed, the channel "%s" does not exist.', channel)
    end

    --~ ?

    channel = channels:get(channel) --[[@as Channel]]
    local listener = channel:retrieveListener(identifier) --[[@as NetworkListener]]

    if not listener then
      exception('Listener removal failed, could not find listener "%s" on channel "%s".', identifier, channel.name)
    end

    if listener.owner ~= context then
      exception('Listener removal failed, listener "%s" belong to a different context.', identifier)
    end

    channel:removeListener(identifier)
  end,

  --
  -- Triggers all listeners registered to a specific channel, passing them the provided arguments,
  -- while also ensuring the channel exists and the caller is authorized to trigger it.
  --
  triggerChannel = function(channel, arguments, context)
    --~ Validate input arguments to ensure they are of the
    --~ correct type to prevent potential errors.

    if type(channel) ~= 'string' then
      exception('Invalid channel name. Expected a string.')
    end

    if arguments and type(arguments) ~= 'table' then
      exception('Invalid arguments. Expected a table or nil.')
    end

    if context and type(context) ~= 'string' then
      exception('Invalid context. Expected a string representing a plugin.')
    end

    if not channels:entryExists(channel) then
      exception('Channel trigger failed, the channel "%s" does not exist.', channel)
    end

    --~ Retrieve the channel and verify ownership before triggering.

    channel = channels:get(channel) --[[@as Channel]]

    if channel.owner ~= context then
      exception(
        'Channel trigger failed: Plugin "%s" is not authorized '
        .. 'to trigger channel "%s".', context, channel.name
      )
    end

    channel:invokeListeners(arguments, channel.async)
  end
}

--
-- Reserves the 'PLUGIN_ADDED' channel for exclusive use by the framework
-- to notify other parts of the system when a new plugin is created.
--
controller.reserveChannel('PLUGIN_ADDED', { async = false, internal = true })

--
-- Expose the network controller to other framework modules.
--
framework.export('module/network', controller)
