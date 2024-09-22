--[[

  Project: Backbone (framework)  
  Version: 1.0.0
  
  Author(s): Erik Riklund

  Description:
  Backbone is a foundational framework that provides key utilities and structures 
  to streamline the development of addons. It includes features such as ...

]]

local api = {
  framework = {} --[[@as api]],
  plugin = {} --[[@as plugin]],
}

local frame = CreateFrame 'Frame' --[[@as Frame]]

--#region [module: plugins]

--[[

  Module: Plugin Management
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Provides functionality for creating and managing plugins. This module ensures 
  that plugins are uniquely identified and registered within the framework.

  Notes:

  - Plugins are stored in the `plugins` table, indexed by their unique identifiers.

]]

---
--- A table storing all registered plugins, indexed by their unique identifiers.
---
--- @type table<string, plugin>
---
local plugins = {}

---
--- Creates a new plugin with a unique identifier. If a plugin with the same identifier
--- already exists, an error is thrown.
---
--- @param identifier string "A unique identifier for the plugin."
--- @return plugin "The newly created plugin instance."
---
api.framework.createPlugin = function(identifier)
  --
  -- Ensures that the plugin identifier is unique.

  if plugins[identifier] ~= nil then
    throwError('Unable to create plugin "%s" (non-unique identifier).', identifier)
  end

  -- Registers the plugin and sets up inheritance from the `api.plugin` class.

  plugins[identifier] = setmetatable({ identifier = identifier }, { __index = api.plugin })

  -- Returns the plugin wrapped in a protected proxy to prevent unauthorized modifications.

  return xtable.getProtectedProxy(plugins[identifier])
end

--#endregion

--#region [module: callbacks]

--[[

  Project: Backbone (framework)
  Module: Callback Management
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Manages the execution of callback functions, both synchronously and asynchronously. 
  This module provides a task queue for asynchronous callbacks and ensures that callbacks 
  are executed within the frame time limit to maintain performance.

  Notes:

  - Asynchronous tasks are processed in the background using a coroutine to respect 
    frame limits and prevent performance degradation.

]]

---
--- A list of tasks queued for asynchronous execution.
---
--- @type task[]
---
local tasks = {}

---
--- Executes a callback function associated with an identifier. This function validates
--- the arguments, executes the callback safely, and handles errors that occur during
--- execution.
---
--- @param identifier  string     "A unique identifier for the callback."
--- @param callback    function   "The callback function to execute."
--- @param arguments?  unknown[]  "Optional arguments to pass to the callback."
---
local executeCallback = function(identifier, callback, arguments)
  --
  -- Validates the input arguments to ensure they are of the correct types.

  validateArguments {
    { label = 'identifier', value = identifier, types = 'string' },
    { label = 'callback', value = callback, types = 'function' },
    { label = 'arguments', value = arguments, types = 'array', optional = true },
  }

  -- Attempts to execute the callback function using `pcall`, passing the arguments.

  local success, result = pcall(callback, (arguments ~= nil and unpack(arguments)) or nil)

  -- If the callback execution fails, an error is raised.

  if not success then throwError('Execution of callback "%s" failed. Reason: %s', identifier, result) end
end

---
--- Processes asynchronous tasks, ensuring that tasks are executed within a frame limit
--- for performance reasons. Uses coroutines and timers to manage execution time.
---
local process --[[@as thread]]
process = coroutine.create(function()
  --
  -- Defines the time limit per frame to ensure the task execution doesn't exceed 60fps.

  local frameLimit = 0.01667

  -- A continuous loop to keep the process alive in the background.

  while true do
    --
    -- Records the start time to compare against the frame limit.

    local started = GetTime()

    -- Executes tasks within the frame time limit.

    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      --
      -- Removes the first task from the queue and executes the callback.

      local task = table.remove(tasks, 1) --[[@as task]]
      executeCallback(task.identifier, task.callback, task.arguments)
    end

    -- If tasks remain, schedule the next processing loop after the frame limit delay.

    if #tasks > 0 then C_Timer.After(frameLimit, function() coroutine.resume(process) end) end

    -- Yields control back to the main program until resumed.

    coroutine.yield()
  end
end)

---
--- Queues a callback function for asynchronous execution. The callback is identified
--- by a unique identifier and can optionally receive arguments. The task is executed
--- when the coroutine resumes within the frame limit.
---
--- @param identifier  string     "A unique identifier for the callback."
--- @param callback    function   "The callback function to execute."
--- @param arguments?  unknown[]  "Optional arguments to pass to the callback."
---
local executeCallbackAsync = function(identifier, callback, arguments)
  --
  -- Adds the task to the queue for asynchronous execution.

  table.insert(tasks, { identifier = identifier, callback = callback, arguments = arguments } --[[@as task]])

  -- Resumes the coroutine if it's suspended, triggering the processing loop.

  if coroutine.status(process) == 'suspended' then coroutine.resume(process) end
end

-- Exposes the `executeCallback` and `executeCallbackAsync` functions through the framework API.

api.framework.executeCallback = executeCallback
api.framework.executeCallbackAsync = executeCallbackAsync

--#endregion

--#region [class: listenable]

--[[

  Project: Backbone (framework)
  Class: Listenable
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Provides functionality to register, invoke, and remove listeners. The `listenable` 
  class supports asynchronous and synchronous execution of registered listeners 
  and ensures listener management through unique identifiers.

  Notes:

  - Listeners are stored in the `listeners` table.
  - Non-persistent listeners are removed after execution.

]]

---
--- A class that manages the registration, invocation, and removal of listeners.
--- This class supports both synchronous and asynchronous listener execution.
---
local listenable = {
  __index = {
    --
    -- Invokes all registered listeners, passing the provided arguments to their
    -- respective callback functions. Supports both synchronous and asynchronous execution.

    invokeListeners = function(self, arguments, executeAsync)
      --
      -- Validate the input arguments to avoid unexpected behavior.

      validateArguments {
        { label = 'arguments', value = arguments, types = 'array', optional = true },
        { label = 'executeAsync', value = executeAsync, types = 'boolean', optional = true },
      }

      -- Execute each listener's callback, either synchronously or asynchronously.

      for i = 1, #self.listeners do
        --
        -- Executes the callback asynchronously or synchronously based on the flag.

        local handler = (executeAsync and executeCallbackAsync) or executeCallback
        handler(self.listeners[i].identifier, self.listeners[i].callback, arguments or {})

        -- If the listener is not persistent, it is removed after execution.

        if self.listeners[i].persistent == false then
          table.remove(self.listeners, i)
          i = i - 1 -- adjusts the index to ensure correct iteration after removal.
        end
      end
    end,

    -- Registers a new listener with a callback function, optional identifier,
    -- and persistence flag. Ensures that all fields are of the correct types.

    registerListener = function(self, listener)
      --
      -- Validate the listener structure and its fields.

      validateArguments {
        { label = 'listener', value = listener, types = 'table' },
        { label = 'listener.callback', value = listener.callback, types = 'function' },
        { label = 'listener.identifier', value = listener.identifier, types = 'string' },
        { label = 'listener.persistent', value = listener.persistent, types = 'boolean', optional = true },
      }

      -- Insert the validated listener into the list of listeners.

      table.insert(self.listeners, listener)
    end,

    -- Removes a listener by its identifier. Throws an error if no listener with
    -- the given identifier is found.

    removeListener = function(self, identifier)
      --
      -- Validate that the identifier is a string.

      validateArguments {
        { label = 'identifier', value = identifier, types = 'string' },
      }

      -- Search for the listener by identifier and remove it if found.

      for index, listener in ipairs(self.listeners) do
        if listener.identifier == identifier then
          table.remove(self.listeners, index)
          return -- exits after the listener is removed.
        end
      end

      -- Throws an error if the listener with the given identifier was not found.

      throwError('Failed to remove listener "%s" (unknown identifier).', identifier)
    end,
  } --[[@as listenable]],
}

---
--- Creates a new `listenable` object, initializing it with an empty list of listeners.
--- @return listenable "The newly created listenable object."
---
local createListenableObject = function() return setmetatable({ listeners = {} }, listenable) end

--#endregion

--#region [module: game events]

--[[

  Project: Backbone (framework)
  Module: Game Events
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Manages the registration, invocation, and removal of event listeners for game events. 
  It provides functions for handling event listeners, invoking callbacks when events 
  are triggered, and managing event unregistration when no listeners are left.

  Notes:

  - The system handles the `ADDON_LOADED` event specially by prefixing it with the 
    addon's name.

]]

---
--- Stores the registered events, indexed by their names.
---
--- @type table<string, event>
---
local events = {}

-- Registers the initial event listener for ADDON_LOADED.

frame:RegisterEvent 'ADDON_LOADED'

---
--- Registers a new event by name. If the event does not start with `ADDON_LOADED`, it
--- is registered with the frame for listening.
---
--- @param name  string  "The name of the event to register."
---
local registerEvent = function(name)
  if not xstring.hasPrefix(name, 'ADDON_LOADED') then frame:RegisterEvent(name) end
  events[name] = createListenableObject() --[[@as event]]
end

---
--- Unregisters an event by name. If the event is not part of the `ADDON_LOADED` series,
--- it is removed from the frame's registered events.
---
local unregisterEvent = function(name)
  if not xstring.hasPrefix(name, 'ADDON_LOADED') then frame:UnregisterEvent(name) end
  events[name] = nil -- ?
end

---
--- Registers a listener for a specific event. If the event does not exist, it is first
--- registered.
---
--- @param eventName  string   "The name of the event to listen for."
--- @param listener   listener "The listener to register for the event."
---
local registerEventListener = function(eventName, listener)
  if events[eventName] == nil then registerEvent(eventName) end
  events[eventName]:registerListener(listener)
end

---
--- Removes a listener from an event. If no more listeners are left, the event is unregistered.
---
--- @param eventName   string  "The name of the event to remove the listener from."
--- @param identifier  string  "The unique identifier of the listener to remove."
---
local removeEventListener = function(eventName, identifier)
  if events[eventName] ~= nil then events[eventName]:removeListener(identifier) end
  if #events[eventName].listeners == 0 then unregisterEvent(eventName) end
end

---
--- Invokes all listeners registered for a given event, passing the event's arguments.
---
--- @param eventName  string    "The name of the event to invoke."
--- @param arguments  unknown[] "The arguments to pass to the event listeners."
---
local invokeEvent = function(eventName, arguments)
  if events[eventName] ~= nil then events[eventName]:invokeListeners(arguments) end
end

-- Sets up the frame to handle incoming events and invoke the relevant listeners.

frame:SetScript('OnEvent', function(sender, eventName, ...)
  if eventName == 'ADDON_LOADED' then
    local addonName = ...
    eventName = 'ADDON_LOADED:' .. addonName
  end

  invokeEvent(eventName, { ... })
end)

-- Registers a one-time initialization callback for the plugin, triggered when `ADDON_LOADED` fires.

api.plugin.onInitialize = function(self, identifier, callback)
  local listener = { identifier = identifier, callback = callback, persistent = false }
  self:registerEventListener('ADDON_LOADED:' .. self.identifier, listener)
end

-- Registers an event listener for a plugin, appending the plugin identifier to the listener identifier.

api.plugin.registerEventListener = function(self, eventName, listener)
  listener.identifier = self.identifier .. listener.identifier
  registerEventListener(eventName, listener)
end

-- Removes an event listener for a plugin, using the plugin's identifier as a prefix.

api.plugin.removeEventListener = function(self, eventName, identifier)
  identifier = self.identifier .. identifier
  removeEventListener(eventName, identifier)
end

--#endregion

---
--- ?
---
_G.backbone = xtable.getProtectedProxy(api.framework) --[[@as api]]
