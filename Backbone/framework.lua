--[[~ Project: Backbone (framework) ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  Backbone is a framework designed for managing plugin interaction, task scheduling, 
  and event handling. It provides modularity and encapsulation for plugins, ensuring 
  controlled execution of tasks and events. Components are designed to interact 
  through well-defined channels and event listeners, making it easier to manage 
  asynchronous operations.

  Design choices:
  - The framework ensures unique plugin identifiers to avoid conflicts.
  - Tasks are scheduled and executed across multiple frames to maintain smooth rendering.
  - Events are registered and triggered using a flexible listener system.

]]

---@type api
local api = {}

---@type plugin
local plugin = {}

---@type Frame
local frame = CreateFrame 'Frame'

---@type api
_G.backbone = xtable.getProtectedProxy(api)

--
-- This flag can be toggled to enable or disable production-specific behaviors in
-- the framework, allowing different behavior in production vs. development modes.

_G.production = false

--[[~ Module: Plugin Manager ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  The plugin manager is responsible for registering and managing plugins within 
  the framework. Each plugin is identified by a unique string identifier, ensuring 
  that plugins do not conflict. Once registered, each plugin is stored in a protected 
  proxy to prevent external modifications. This allows the framework to maintain 
  control over plugin behaviors while ensuring data integrity.

  Design choices:
  - Plugins must have unique identifiers to avoid conflicts within the framework.
  - Using a proxy for each plugin ensures that plugins cannot be directly modified 
    by external code, protecting the internal state of the system.
  - The `plugins` table is used to track all registered plugins, allowing efficient 
    lookup based on their identifiers.

  Dependencies: None

]]

---@type table<string, plugin>
local plugins = {}

---
--- Registers a new plugin within the framework.
---
--- If a plugin with the same identifier already exists, an error is thrown to prevent
--- conflicts. The newly registered plugin is wrapped in a protected proxy to ensure
--- that external code cannot modify the plugin directly.
---
---@param identifier string "The unique identifier for the plugin being registered."
---
api.createPlugin = function(identifier)
  -- Ensure that the identifier is unique. If it already exists in the `plugins` table,
  -- raise an error to prevent conflicts.

  if plugins[identifier] ~= nil then
    throwError('Unable to register plugin "%s" (non-unique identifier).', identifier)
  end

  -- Register the plugin and associate it with the identifier in the `plugins` table.
  -- Set the plugin's metatable to inherit methods from the base `plugin` object.

  plugins[identifier] = setmetatable(
    { identifier = identifier },
    { __index = plugin }
  )

  -- Return a protected proxy to the registered plugin to ensure that the plugin cannot
  -- be directly modified by external code.

  return xtable.getProtectedProxy(plugins[identifier]) --[[@as plugin]]
end

--[[~ Module: Task Management ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  The task management module is responsible for scheduling and executing tasks 
  within the framework. It supports both synchronous and asynchronous task execution, 
  allowing for deferred processing across multiple frames. This helps maintain 
  smooth rendering by distributing the workload over time.

  Design choices:
  - Tasks are processed asynchronously to prevent frame rate drops, ensuring smooth 
    gameplay performance.
  - The module provides both immediate (synchronous) and deferred (asynchronous) 
    execution of callbacks based on the needs of the developer.
  - A coroutine-based task processor ensures that tasks are processed within 
    frame time limits, helping to avoid frame stalls.

  Dependencies: None

]]

---@type task[]
local tasks = {}

---
--- Executes a callback immediately. If the callback fails, an error is caught, and
--- the failure is logged. Optional arguments can be provided to the callback.
---
---@param identifier string    "A unique identifier for the callback."
---@param callback   function  "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
local executeCallback = function(identifier, callback, arguments)
  validateArguments {
    { 'identifier:string', identifier },
    { 'callback:function', callback },
    { 'arguments:array?', arguments },
  }

  -- Execute the callback immediately and handle any errors during execution.
  local success, exception = pcall(callback, unpack(arguments or {}))

  -- If execution fails, log the failure along with the exception message.
  if not success then
    print(
      ('[Backbone] Callback execution failed for "%s":\n%s'):format(
        identifier,
        exception
      )
    )
  end
end

---
--- Queues a callback for asynchronous execution. The callback is added to a task queue
--- and will be processed over multiple frames. This prevents overloading a single
--- frame and helps maintain smooth rendering.
---
---@param identifier string    "A unique identifier for the callback."
---@param callback   function  "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
local executeCallbackAsync = function(identifier, callback, arguments)
  -- Add the callback and its associated arguments to the task queue for deferred
  -- execution across frames.
  table.insert(
    tasks,
    { identifier = identifier, callback = callback, arguments = arguments }
  )
end

-- Registers the synchronous and asynchronous execution functions within the API.
api.executeCallback = executeCallback
api.executeCallbackAsync = executeCallbackAsync

--
-- A coroutine-based task processor that executes tasks in small batches, ensuring
-- that the time spent processing tasks does not exceed a frame time limit, preserving
-- smooth rendering and gameplay performance.
--
local process = coroutine.create(function()
  local frameLimit = 0.01667 -- Target frame time to maintain 60 FPS.

  while true do
    local started = GetTime()

    -- Process tasks as long as there is time left in the frame and tasks are pending.
    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as task]]
      executeCallback(task.identifier, task.callback, task.arguments)
    end

    coroutine.yield() -- Yield control until the next frame.
  end
end)

-- The OnUpdate handler resumes the coroutine each frame to process any pending tasks.
-- This ensures that tasks are processed asynchronously while keeping the frame rate stable.
frame:SetScript('OnUpdate', function()
  if #tasks > 0 and coroutine.status(process) == 'suspended' then
    coroutine.resume(process)
  end
end)

--[[~ Component: Listenable ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  The listenable component provides a mechanism for registering and invoking listeners 
  in response to specific events or triggers within the framework. It supports both 
  synchronous and asynchronous execution of listeners, giving flexibility in how 
  events are handled. Listeners can be persistent or removed after being invoked.

  Design choices:
  - The component allows for both immediate (synchronous) and deferred (asynchronous) 
    listener execution, based on developer preferences.
  - Persistent listeners remain registered until explicitly removed, while non-persistent 
    listeners are automatically removed after invocation.
  - The `listeners` table keeps track of registered listeners and allows efficient 
    lookup and invocation.

  Dependencies: Task Management

]]

---@type listenable
local listenable = {
  --
  -- Invokes all registered listeners, optionally in an asynchronous manner. Non-persistent
  -- listeners are automatically removed after invocation.
  --
  invokeListeners = function(self, arguments, options)
    options = options or {}

    validateArguments {
      { 'arguments:array?', arguments },
      { 'options:table?', options },
      { 'options.async:boolean?', options.async },
    }

    -- Loop through the registered listeners and execute each one.
    for i = 1, #self.listeners do
      local listener = self.listeners[i]
      local handler = (options.async and executeCallbackAsync) or executeCallback
      handler(listener.identifier, listener.callback, arguments or {})

      -- Remove non-persistent listeners after they have been invoked.
      if listener.persistent == false then
        table.remove(self.listeners, i)
        i = i - 1 -- Adjust the index to prevent skipping listeners after removal.
      end
    end
  end,

  --
  -- Registers a listener to be invoked when this listenable is triggered. Each listener
  -- must have a unique identifier and a valid callback function. Optional persistence
  -- determines if the listener remains active after it is invoked.
  --
  registerListener = function(self, listener)
    validateArguments {
      { 'listener:table', listener },
      { 'listener.callback:function', listener.callback },
      { 'listener.identifier:string', listener.identifier },
      { 'listener.persistent:boolean?', listener.persistent },
    }

    -- Add the listener to the listeners table for future invocation.
    table.insert(self.listeners, listener)
  end,

  --
  -- Removes a listener based on its unique identifier. If the listener does not exist,
  -- an error is raised.
  --
  removeListener = function(self, identifier)
    validateArguments { { 'identifier:string', identifier } }

    -- Search through the listeners table to find and remove the listener.
    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- Stop further execution after the listener is removed.
      end
    end

    throwError('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,
}

---
--- Creates a new listenable object, allowing the registration and invocation of listeners.
--- Each listenable object tracks its own listeners and manages their invocation.
---
---@return listenable "The newly created listenable object."
---
local createListenableObject = function()
  -- Initialize a listenable object with an empty listeners table and attach the
  -- appropriate methods from the listenable component.
  return setmetatable({ listeners = {} }, { __index = listenable })
end

--[[~ Module: Event Handler ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  The event handler is responsible for managing events in the framework. It allows 
  for the registration of event listeners and handles invoking those listeners 
  when the corresponding event occurs. The module ensures that listeners are removed 
  when no longer needed, helping manage memory usage efficiently.

  Design choices:
  - The event handler automatically registers events when listeners are added, and 
    unregisters them when all listeners for that event are removed.
  - Events are tracked in the `events` table, which maps event names to their corresponding 
    listeners, allowing efficient lookup and management.
  - Support is provided for dynamically generated event names, such as `ADDON_LOADED`.

  Dependencies: Listenable

]]

---@type table<string, event>
local events = {}

--
-- Registers the ADDON_LOADED event initially, as it is required for most plugin
-- initialization processes.
--
frame:RegisterEvent 'ADDON_LOADED'

---
--- Registers a listener for a given event. If the event is not already registered,
--- it is added to the `events` table and registered with the game. The listener
--- will be invoked when the event is triggered.
---
---@param event    string   "The name of the event to listen for."
---@param listener listener "The listener to attach to the event."
---
local registerEventListener = function(event, listener)
  -- Check if the event is not already registered. If not, register the event and
  -- associate it with a new listenable object.
  if events[event] == nil then
    if not xstring.hasPrefix(event, 'ADDON_LOADED') then
      frame:RegisterEvent(event)
    end
    events[event] = createListenableObject() --[[@as event]]
  end

  -- Register the listener for the specified event.
  events[event]:registerListener(listener)
end

---
--- Removes a listener from the specified event. If the listener is successfully
--- removed and no listeners remain for the event, the event is unregistered.
---
---@param event      string "The event name from which to remove the listener."
---@param identifier string "The unique identifier for the listener to remove."
---
local removeEventListener = function(event, identifier)
  -- Check if the event has any registered listeners. If it does, attempt to remove
  -- the listener with the specified identifier.
  if events[event] ~= nil then
    events[event]:removeListener(identifier)

    -- If no listeners remain, unregister the event to conserve resources.
    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then
        frame:UnregisterEvent(event)
      end
      events[event] = nil -- Clear the event to free memory.
    end
    return
  end

  throwError('Event "%s" has no active listeners.', event)
end

--
-- The OnEvent handler is triggered whenever a registered event occurs. It checks
-- for the existence of listeners for the event and invokes them if any are found.
--
frame:SetScript('OnEvent', function(source, event, ...)
  -- Handle the special case for the ADDON_LOADED event, which may be specific to
  -- a particular addon. Dynamically update the event name to include the addon name.
  if event == 'ADDON_LOADED' then event = string.format('ADDON_LOADED:%s', ...) end

  -- If listeners are registered for the event, invoke them with the event arguments.
  if events[event] ~= nil then
    events[event]:invokeListeners { source, ... }

    -- If no listeners remain after invocation, unregister the event to conserve memory.
    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then
        frame:UnregisterEvent(event)
      end
      events[event] = nil -- Clear the event to free memory.
    end
  end
end)

---
--- Initializes a plugin by registering a listener for its `ADDON_LOADED` event.
--- This listener will be triggered when the addon is loaded into memory.
---
plugin.onInitialize = function(self, identifier, callback)
  local listener = {
    identifier = self.identifier .. '.' .. identifier,
    callback = callback,
    persistent = false,
  }

  -- Register the listener for the specific addon event.
  registerEventListener('ADDON_LOADED:' .. self.identifier, listener)
end

---
--- Registers a listener for a specified event. The listener's identifier is
--- prepended with the plugin's identifier to ensure uniqueness.
---
plugin.registerEventListener = function(self, event, listener)
  listener.identifier = self.identifier .. '.' .. listener.identifier
  registerEventListener(event, listener)
end

---
--- Removes a listener from the specified event using the plugin's unique identifier.
---
plugin.removeEventListener = function(self, event, identifier)
  removeEventListener(event, self.identifier .. '.' .. identifier)
end

--[[~ Module: Channel Manager ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  The channel manager is responsible for managing communication channels within 
  the framework. Channels allow plugins or components to communicate by sending 
  and receiving messages. Each channel has an identifier and can be reserved, 
  meaning only the owner (the plugin or component that reserved it) can control 
  the listeners attached to it.

  Design choices:
  - Channels can be internal or external. Internal channels can only be accessed 
    by the owning plugin, while external channels are available to multiple plugins.
  - Async channels allow for deferred message handling, ensuring non-blocking 
    communication across components.
  - Listeners can be registered to channels, and only the owner can remove or 
    invoke listeners on internal channels.

  Dependencies: Listenable

]]

---@type table<string, channel>
local channels = {}

---
--- Reserves a new channel. If the channel already exists, an error is thrown.
--- A reserved channel can be internal, which limits access to the plugin that reserved
--- it. Channels can also be asynchronous, where message handling is deferred.
---
---@param channel   string "The unique name of the channel to be reserved."
---@param options   table  "Channel options (async, internal)."
---@param context?  plugin "The plugin reserving the channel (used for internal channels)."
---
local reserveChannel = function(channel, options, context)
  options = options or {}

  validateArguments {
    { 'channel:string', channel },
    { 'options.async:boolean?', options.async },
    { 'options.internal:boolean?', options.internal },
  }

  -- Check if the channel already exists, and raise an error if it's not unique.
  if channels[channel] ~= nil then
    throwError('Unable to reserve channel "%s" (non-unique name).', channel)
  end

  -- Create a new channel with the specified options and context.
  channels[channel] = createListenableObject() --[[@as channel]]
  channels[channel].async = options.async
  channels[channel].internal = options.internal
  channels[channel].context = context
end

---
--- Registers a listener to a specified channel. If the channel is internal, only
--- the plugin that owns the channel can register listeners. If the channel does
--- not exist, an error is thrown.
---
---@param channel   string   "The name of the channel to register the listener on."
---@param listener  listener "The listener to be attached to the channel."
---@param context?  plugin   "The plugin attempting to register the listener."
---
local registerChannelListener = function(channel, listener, context)
  validateArguments {
    { 'channel:string', channel },
    { 'listener:table', listener },
    { 'context:table?', context },
  }

  -- Ensure the channel exists, otherwise raise an error.
  if channels[channel] == nil then
    throwError(
      'Failed to register listener to channel "%s" (unknown channel).',
      channel
    )
  end

  -- For internal channels, ensure only the owning context can register listeners.
  if channels[channel].internal == true and channels[channel].context ~= context then
    throwError(
      'Failed to register listener to channel "%s" (internal channel).',
      channel
    )
  end

  -- If a context is provided, prepend its identifier to the listener's identifier.
  if context ~= nil then
    listener.identifier = context.identifier .. '.' .. listener.identifier
  end

  -- Register the listener on the channel.
  channels[channel]:registerListener(listener)
end

---
--- Removes a listener from a channel based on its identifier. For internal channels,
--- only the owning plugin can remove listeners. If the channel does not exist, an error
--- is thrown.
---
---@param channel    string "The name of the channel to remove the listener from."
---@param identifier string "The unique identifier of the listener to be removed."
---@param context?   plugin "The plugin attempting to remove the listener."
---
local removeChannelListener = function(channel, identifier, context)
  validateArguments {
    { 'channel:string', channel },
    { 'identifier:string', identifier },
    { 'context:table?', context },
  }

  -- Ensure the channel exists, otherwise raise an error.
  if channels[channel] == nil then
    throwError(
      'Failed to remove listener from channel "%s" (unknown channel).',
      channel
    )
  end

  -- If a context is provided, prepend its identifier to the listener's identifier.
  if context ~= nil then identifier = context.identifier .. '.' .. identifier end

  -- Remove the listener from the specified channel.
  channels[channel]:removeListener(identifier)
end

---
--- Invokes listeners attached to a specified channel. For internal channels,
--- only the owning plugin can invoke listeners. If the channel does not exist,
--- an error is thrown.
---
---@param channel   string    "The name of the channel."
---@param payload?  unknown[] "Optional data to send to the listeners."
---@param context?  plugin    "The plugin invoking the listeners."
---
local invokeChannelListeners = function(channel, payload, context)
  validateArguments {
    { 'channel:string', channel },
    { 'context:table?', context },
  }

  -- Ensure the channel exists, otherwise raise an error.
  if channels[channel] == nil then
    throwError(
      'Failed to invoke listeners on channel "%s" (unknown channel).',
      channel
    )
  end

  -- For internal channels, only the owning context can invoke listeners.
  if channels[channel].context ~= context then
    throwError(
      'Failed to invoke listeners on channel "%s" (calling context is not the owner).',
      channel
    )
  end

  -- Invoke the listeners on the channel, using async mode if specified.
  channels[channel]:invokeListeners(payload, { async = channels[channel].async })
end

---
--- Reserves a special internal channel for registering new plugins.
---
reserveChannel('PLUGIN_ADDED', { async = false, internal = true })

---
--- Reserves a channel for a plugin. This ensures that the plugin controls
--- the channel and its listeners.
---
plugin.reserveChannel = function(self, channel, options)
  reserveChannel(channel, options, self)
end

---
--- Registers a listener for a channel on behalf of the plugin.
---
plugin.registerChannelListener = function(self, channel, listener)
  registerChannelListener(channel, listener, self)
end

---
--- Removes a listener from a channel using the plugin's unique identifier.
---
plugin.removeChannelListener = function(self, channel, identifier)
  removeChannelListener(channel, identifier, self)
end

---
--- Invokes listeners on a channel on behalf of the plugin.
---
plugin.invokeChannelListeners = function(self, channel, payload)
  invokeChannelListeners(channel, payload, self)
end

--[[~ Component: Storage Unit ~
  
  Version: 1.0.0 | Updated: 2024/09/24

  ?

  Dependencies: ?

]]

--[[~ Module: Storage Manager ~
  
  Version: 1.0.0 | Updated: 2024/09/24

  ?

  Dependencies: ?

]]

---@type table<string, { account?: storage.unit, character?: storage.unit }>
local storage = {}

---
--- ?
---
---@param context   plugin "..."
---@param scope     storage.scope "..."
---@param variable  string "..."
---
local setupStorage = function(context, scope, variable) end

---
--- ?
---
api.useStorage = function(context, variables)
  validateArguments { { 'variables:table', variables } }

  context:onInitialize('INIT_STORAGE', function()
    for scope, variable in pairs(variables) do
      setupStorage(context, scope, variable)
    end
  end)
end

---
--- ?
---
plugin.getAccountVariable = function(self, identifier)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
plugin.setAccountVariable = function(self, identifier, value) end

---
--- ?
---
plugin.getCharacterVariable = function(self, identifier)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
plugin.setCharacterVariable = function(self, identifier, value) end
