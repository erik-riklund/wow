--[[~ Project: Backbone (framework) ~

  Version: 1.0.0
  Author(s): Erik Riklund
  
  This framework provides the foundation for managing plugins, tasks, and event listeners 
  in a structured and flexible manner. It prioritizes immutability, preventing accidental 
  modifications, and ensuring the consistency and reliability of the framework's components.

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
-- The production flag is used to toggle between production and development modes.
-- In production, certain behaviors like verbose logging and debug tools can be
-- disabled to optimize performance and minimize overhead.

_G.production = false

--[[~ Module: Plugin Manager ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/23

  This module handles the creation and management of plugins. Plugins are registered 
  with a unique identifier to prevent conflicts, and once registered, their state 
  becomes immutable. Immutability guarantees the integrity of each plugin, preventing 
  any unintentional changes that could lead to unpredictable behavior.

]]

---@type table<string, plugin>
local plugins = {}

---
--- Registers a new plugin using a unique identifier. This ensures that no two
--- plugins share the same identifier, preventing conflicts or overwrites.
--- Once registered, the plugin is immutable, making it safe from accidental changes.
---
---@param identifier string "A unique identifier for the plugin."
---
api.createPlugin = function(identifier)
  -- Check for unique identifiers to prevent accidental overwrites or conflicts.
  -- This guarantees that each plugin operates in isolation, avoiding any unintended
  -- interactions with other plugins.

  if plugins[identifier] ~= nil then
    throwError('Unable to register plugin "%s" (non-unique identifier).', identifier)
  end

  -- Create a new plugin, inheriting shared behavior from the base `plugin` class.
  -- Inheriting common behavior reduces duplication and makes the code easier to
  -- maintain across different plugins.

  plugins[identifier] = setmetatable({ identifier = identifier }, { __index = plugin })

  -- Return the plugin wrapped in a protected proxy. Immutability ensures that once
  -- a plugin is registered, its internal state cannot be modified, reducing the
  -- potential for bugs caused by accidental changes.

  return xtable.getProtectedProxy(plugins[identifier])
end

--[[~ Module: Task Management ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/23

  This module handles task execution, both synchronous and asynchronous. Tasks are 
  processed within a frame limit to maintain system performance, ensuring that no 
  single task hogs too much processing time. Asynchronous tasks are queued to be 
  executed when the system allows, avoiding performance bottlenecks.

]]

---@type task[]
local tasks = {}

---
--- Executes a callback function after validating its arguments. If an error occurs
--- during execution, it is caught and logged. This ensures that the system can
--- handle faulty callbacks without crashing or stopping other tasks from executing.
---
---@param identifier string    "A unique identifier for the callback."
---@param callback   function  "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
local executeCallback = function(identifier, callback, arguments)
  -- Validate arguments to avoid issues caused by incorrect types or missing values.
  -- This is particularly important for callback functions, as invalid arguments
  -- could cause unexpected crashes or bugs.

  validateArguments {
    { 'identifier:string', identifier },
    { 'callback:function', callback },
    { 'arguments:array?', arguments },
  }

  -- Use `pcall` to safely execute the callback and catch any errors. This allows
  -- the system to continue running even if a callback fails, logging the error
  -- instead of crashing.

  local success, exception = pcall(callback, unpack(arguments or {}))

  -- If the callback fails, log the error with the identifier for easier debugging.
  -- Logging the identifier helps trace the exact callback that caused the issue.

  if not success then
    print(('[Backbone] Callback execution failed for "%s":\n%s'):format(identifier, exception))
  end
end

-- Expose the `executeCallback` function as part of the public API, making it available
-- for other modules or systems to call.

api.executeCallback = executeCallback

---
--- Queues a callback for asynchronous execution. This allows the system to defer
--- task execution to a later point, avoiding performance degradation by spreading
--- tasks over multiple frames.
---
---@param identifier string    "A unique identifier for the callback."
---@param callback   function  "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
local executeCallbackAsync = function(identifier, callback, arguments)
  -- Insert the task into the queue, deferring its execution to a later time. This prevents
  -- long-running tasks from blocking the main thread and causing performance issues.

  table.insert(tasks, { identifier = identifier, callback = callback, arguments = arguments })
end

-- Expose the `executeCallbackAsync` function to the API, making it available for
-- other parts of the system to use when they need to queue tasks for asynchronous execution.

api.executeCallbackAsync = executeCallbackAsync

--
-- This coroutine handles task execution within a frame limit. It ensures that tasks
-- are processed without exceeding the frame time limit, preserving the system's
-- responsiveness and preventing performance bottlenecks.
--
local process = coroutine.create(function()
  local frameLimit = 0.01667 -- ensures smooth rendering, target is 60FPS.

  while true do
    local started = GetTime()

    -- Execute tasks within the frame time limit to maintain performance. Tasks
    -- are processed as long as they fit within the remaining time for the current frame.

    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as task]]
      executeCallback(task.identifier, task.callback, task.arguments)
    end

    coroutine.yield() -- Yield control until the next frame.
  end
end)

-- This script is triggered every frame, ensuring that queued tasks are processed
-- without affecting the performance of other systems or causing frame drops.

frame:SetScript('OnUpdate', function()
  if #tasks > 0 and coroutine.status(process) == 'suspended' then coroutine.resume(process) end
end)

--[[~ Component: Listenable ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/23

  The `Listenable` component provides a flexible way to manage event listeners. 
  It supports both synchronous and asynchronous execution, with automatic removal 
  of non-persistent listeners once they have been triggered.

]]

---@type listenable
local listenable = {
  --
  -- Invokes all registered listeners for a given event. Supports both synchronous
  -- and asynchronous execution depending on the options provided. Non-persistent
  -- listeners are automatically removed after they have been triggered, preventing
  -- memory leaks or unintended behavior.

  invokeListeners = function(self, arguments, options)
    options = options or {}

    -- Validate input to ensure correct behavior when invoking listeners. This
    -- ensures that the system behaves predictably even when provided with various
    -- options or arguments.

    validateArguments {
      { 'arguments:array?', arguments },
      { 'options:table?', options },
      { 'options.async:boolean?', options.async },
    }

    -- Loop through all listeners, invoking each one and handling non-persistent
    -- listeners. Non-persistent listeners are removed after they are triggered to
    -- prevent further invocations and free up memory.

    for i = 1, #self.listeners do
      local listener = self.listeners[i]
      local handler = (options.async and executeCallbackAsync) or executeCallback
      handler(listener.identifier, listener.callback, arguments or {})

      -- Remove non-persistent listeners once they've been invoked, ensuring that
      -- they are only triggered once and do not persist in memory.

      if listener.persistent == false then
        table.remove(self.listeners, i)
        i = i - 1 -- Adjust the index to prevent skipping listeners after removal.
      end
    end
  end,

  --
  -- Registers a listener by validating its structure. This prevents the registration
  -- of invalid listeners that could cause issues during execution. Consistency in
  -- listener structure helps avoid bugs and improves maintainability.

  registerListener = function(self, listener)
    -- Ensure listeners are structured correctly before registration, enforcing
    -- consistency in the way listeners are handled and invoked.

    validateArguments {
      { 'listener:table', listener },
      { 'listener.callback:function', listener.callback },
      { 'listener.identifier:string', listener.identifier },
      { 'listener.persistent:boolean?', listener.persistent },
    }

    -- Add the listener to the list for future invocations.

    table.insert(self.listeners, listener)
  end,

  --
  -- Removes a listener by its identifier. This ensures that only the correct
  -- listener is removed, preventing unintended behavior caused by removing the
  -- wrong listener.

  removeListener = function(self, identifier)
    -- Validate the identifier to ensure it’s in the correct format, avoiding issues
    -- during listener removal.

    validateArguments { { 'identifier:string', identifier } }

    -- Search for the listener and remove it if found. If no listener is found, an
    -- error is thrown to notify the developer.

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- Stop further execution after the listener is removed.
      end
    end

    -- Provide clear feedback if the listener was not found, aiding debugging and
    -- preventing silent failures.

    throwError('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,
}

---
--- Creates a new `Listenable` object. This provides an easy-to-use interface for
--- managing listeners, allowing developers to register, invoke, and remove listeners
--- in a consistent and predictable manner.
---
---@return listenable "The newly created listenable object."
---
local createListenableObject = function()
  return setmetatable({ listeners = {} }, { __index = listenable })
end

--[[~ Module: Event Handler ~

  Version: 1.0.0 | Updated: 2024/09/23

  This module handles the registration, invocation, and removal of event listeners 
  for game events. Listeners are tied to specific events, and when the event is 
  triggered, the listeners are invoked. Event listeners are removed automatically 
  when no longer needed, preventing unnecessary memory usage. Special handling is 
  provided for the `ADDON_LOADED` event to ensure plugins initialize properly.

]]

---@type table<string, event>
local events = {}

--
-- Register the `ADDON_LOADED` event to ensure that plugins are initialized when the addon
-- they belong to is fully loaded. This event is critical for proper plugin initialization.

frame:RegisterEvent 'ADDON_LOADED'

---
--- Registers a listener for a specific event. If the event has not been registered
--- yet, it is added to the system and the listener is attached. Only registering
--- events when necessary reduces overhead and keeps the system efficient.
---
---@param event    string   "The name of the event to listen for."
---@param listener listener "The listener to attach to the event."
---
local registerEventListener = function(event, listener)
  -- Only register the event if it hasn’t been registered yet. This avoids redundant
  -- registrations, improving performance and preventing unnecessary memory usage.

  if events[event] == nil then
    -- Special case for the `ADDON_LOADED` event, which is managed separately to
    -- avoid re-registering for multiple addons.

    if not xstring.hasPrefix(event, 'ADDON_LOADED') then frame:RegisterEvent(event) end

    -- Create a new listenable object to manage listeners for the event.

    events[event] = createListenableObject() --[[@as event]]
  end

  -- Attach the listener to the event. When the event is triggered, the listener
  -- will be invoked with the appropriate context and arguments.

  events[event]:registerListener(listener)
end

---
--- Removes a listener from a registered event. If no listeners remain for the event,
--- the event itself is unregistered to prevent unnecessary overhead. This approach
--- helps ensure efficient memory usage.
---
---@param event      string "The event name from which to remove the listener."
---@param identifier string "The unique identifier for the listener to remove."
---
local removeEventListener = function(event, identifier)
  -- Check if the event has active listeners before attempting to remove one. If
  -- no listeners exist, an error is thrown to prevent silent failures.

  if events[event] ~= nil then
    events[event]:removeListener(identifier)
    return -- Early exit if the listener was successfully removed.
  end

  -- If the event had no listeners, provide clear feedback to the developer. This
  -- helps avoid confusion when debugging event listener issues.

  throwError('Event "%s" has no active listeners.', event)
end

--
-- This function is triggered whenever an event occurs. It handles invoking all
-- registered listeners and performs cleanup if no listeners remain. By unregistering
-- events with no listeners, we prevent memory bloat and improve overall system performance.

frame:SetScript('OnEvent', function(source, event, ...)
  -- Special case handling for `ADDON_LOADED` to ensure that addon-specific events
  -- are handled correctly, with each addon receiving its own event trigger.

  if event == 'ADDON_LOADED' then event = string.format('ADDON_LOADED:%s', ...) end

  -- Invoke listeners for the event. If no listeners remain afterward, the event
  -- is unregistered to prevent further overhead.

  if events[event] ~= nil then
    events[event]:invokeListeners { source, ... }

    -- If no listeners are left, unregister the event to free up resources. This
    -- prevents unnecessary listeners from accumulating, which could degrade performance.

    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then frame:UnregisterEvent(event) end
      events[event] = nil -- Remove the event to conserve memory.
    end
  end
end)

---
--- Registers a listener for the `ADDON_LOADED` event, specific to a plugin. This
--- ensures that each plugin initializes at the appropriate time when its addon is loaded.
---
plugin.onInitialize = function(self, identifier, callback)
  -- Create a uniquely identified listener by combining the plugin identifier and
  -- the listener identifier. This prevents conflicts between multiple plugins.

  local listener = {
    identifier = self.identifier .. identifier,
    callback = callback,
    persistent = false,
  }

  -- Register the listener for the `ADDON_LOADED` event, ensuring that it is triggered
  -- when the addon is fully loaded.

  registerEventListener('ADDON_LOADED:' .. self.identifier, listener)
end

---
--- Registers a listener for any event, ensuring that the listener identifier is unique
--- to the plugin. This avoids conflicts between plugins that may be listening for
--- the same event.
---
plugin.registerEventListener = function(self, event, listener)
  -- Prefix the listener identifier with the plugin’s identifier to avoid conflicts
  -- with listeners from other plugins.

  listener.identifier = self.identifier .. '.' .. listener.identifier

  -- Register the listener for the event, ensuring that it is triggered when the event occurs.

  registerEventListener(event, listener)
end

---
--- Removes a listener for any event, ensuring that only the correct listener is
--- removed. The plugin's identifier is used as a prefix to avoid removing listeners
--- registered by other plugins.
---
plugin.removeEventListener = function(self, event, identifier)
  -- Prefix the identifier with the plugin’s identifier to ensure that only the intended
  -- listener is removed, even if multiple plugins are listening for the same event.

  removeEventListener(event, self.identifier .. '.' .. identifier)
end
