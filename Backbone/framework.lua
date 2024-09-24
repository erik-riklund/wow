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
  Version: 1.0.0 | Updated: 2024/09/24

  This module handles the management of plugins in the system. Its primary responsibility 
  is to ensure that each plugin is registered with a unique identifier and that the plugins 
  are protected from direct modification by external entities. Plugins are wrapped in 
  a proxy, which helps maintain controlled access and modification restrictions.

  Design choices:
  - Unique identifiers for plugins prevent conflicts when registering multiple plugins.
  - The use of a proxy ensures that plugins cannot be directly modified, enhancing safety.
  - Internal storage of plugins is handled via a table for efficient lookup based on 
    the identifier.

  Dependencies: xtable

]]

---@type table<string, plugin>
local plugins = {}

---
--- Registers a plugin with a given identifier. If a plugin with the same identifier already
--- exists, the function throws an error to prevent identifier conflicts. The newly registered
--- plugin is wrapped in a protected proxy, limiting external modification.
---
---@param identifier string "The identifier for the plugin being registered."
---
api.createPlugin = function(identifier)
  --
  -- First, ensure that the plugin identifier is unique. If a plugin with the same
  -- identifier is already registered, raise an error to prevent conflicts.

  if plugins[identifier] ~= nil then
    throwError('Unable to register plugin "%s" (non-unique identifier).', identifier)
  end

  -- Register the new plugin and associate it with the identifier in the plugins table.
  -- The use of setmetatable allows the plugin to inherit methods from the base plugin object.

  plugins[identifier] = setmetatable({ identifier = identifier }, { __index = plugin })

  -- Return a protected proxy for the registered plugin to ensure that the plugin cannot
  -- be modified directly by external code. This reinforces safety and data encapsulation.

  return xtable.getProtectedProxy(plugins[identifier])
end

--[[~ Module: Task Management ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/23

  This module handles task execution, both synchronous and asynchronous. Tasks are 
  processed within a frame limit to maintain system performance, ensuring that no 
  single task hogs too much processing time. Asynchronous tasks are queued to be 
  executed when the system allows, avoiding performance bottlenecks.

  Dependencies: ?

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

  Dependencies: ?

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
--- ?
---
---@return listenable "The newly created listenable object."
---
local createListenableObject = function()
  return setmetatable({ listeners = {} }, { __index = listenable })
end

--[[~ Module: Event Handler ~

  Version: 1.0.0 | Updated: 2024/09/23

  ?

  Dependencies: ?

]]

---@type table<string, event>
local events = {}

--
-- ?

frame:RegisterEvent 'ADDON_LOADED'

---
--- ?
---
---@param event    string   "The name of the event to listen for."
---@param listener listener "The listener to attach to the event."
---
local registerEventListener = function(event, listener)
  if events[event] == nil then
    if not xstring.hasPrefix(event, 'ADDON_LOADED') then frame:RegisterEvent(event) end
    events[event] = createListenableObject() --[[@as event]]
  end

  events[event]:registerListener(listener)
end

---
--- ?
---
---@param event      string "The event name from which to remove the listener."
---@param identifier string "The unique identifier for the listener to remove."
---
local removeEventListener = function(event, identifier)
  if events[event] ~= nil then
    events[event]:removeListener(identifier)
    return -- Early exit if the listener was successfully removed.
  end

  throwError('Event "%s" has no active listeners.', event)
end

--
-- ?

frame:SetScript('OnEvent', function(source, event, ...)
  if event == 'ADDON_LOADED' then event = string.format('ADDON_LOADED:%s', ...) end

  if events[event] ~= nil then
    events[event]:invokeListeners { source, ... }

    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then frame:UnregisterEvent(event) end
      events[event] = nil -- Remove the event to conserve memory.
    end
  end
end)

---
--- ?

plugin.onInitialize = function(self, identifier, callback)
  local listener = {
    identifier = self.identifier .. identifier,
    callback = callback,
    persistent = false,
  }

  registerEventListener('ADDON_LOADED:' .. self.identifier, listener)
end

---
--- ?

plugin.registerEventListener = function(self, event, listener)
  listener.identifier = self.identifier .. '.' .. listener.identifier
  registerEventListener(event, listener)
end

---
--- ?

plugin.removeEventListener = function(self, event, identifier)
  removeEventListener(event, self.identifier .. '.' .. identifier)
end

--[[~ Module: ? ~
  
  Version: 1.0.0 | Updated: 2024/09/24

  ?

  Dependencies: ?

]]

---@type table<string, channel>
local channels = {}

---
--- ?
---
---@param channel   string "..."
---@param options   channel.options "..."
---@param context?  plugin "..."
---
local reserveChannel = function(channel, options, context)
  options = options or {}

  validateArguments {
    { 'channel:string', channel },
    { 'options.async:boolean?', options.async },
    { 'options.internal:boolean?', options.internal },
  }

  if channels[channel] ~= nil then
    throwError('Unable to reserve channel "%s" (non-unique name).', channel)
  end

  channels[channel] = createListenableObject() --[[@as channel]]

  channels[channel].async = options.async
  channels[channel].internal = options.internal
  channels[channel].context = context
end

---
--- ?
---
---@param channel   string "..."
---@param listener  listener "..."
---@param context?  plugin "..."
---
local registerChannelListener = function(channel, listener, context) end

---
--- ?
---
---@param channel    string "..."
---@param identifier string "..."
---@param context?   plugin "..."
---
local removeChannelListener = function(channel, identifier, context) end

---
--- ?
---
---@param channel   string "..."
---@param payload?  unknown "..."
---@param context?  plugin "..."
---
local invokeChannelListeners = function(channel, payload, context) end

---
--- ?
---
reserveChannel('PLUGIN_ADDED', { async = false, internal = true })

---
--- ?
---
plugin.reserveChannel = function(self, channel, options)
  reserveChannel(channel, options, self)
end

---
--- ?
---
plugin.registerChannelListener = function(self, channel, listener)
  registerChannelListener(channel, listener, self)
end

---
--- ?
---
plugin.removeChannelListener = function(self, channel, identifier)
  removeChannelListener(channel, identifier, self)
end

---
--- ?
---
plugin.invokeChannelListeners = function(self, channel, payload)
  invokeChannelListeners(channel, payload, self)
end
