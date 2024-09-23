--[[

  Version: 1.0.0  
  Project: Backbone (framework)  
  Author(s): Erik Riklund
  
  Backbone is a foundational framework that provides key utilities and structures 
  to streamline the development of addons. It includes features such as ...

]]

---@type api
local api = {}

---@type plugin
local plugin = {}

---@type Frame
local frame = CreateFrame 'Frame'

---@type api
_G.backbone = xtable.getProtectedProxy(api)

--[[~

  Module: Plugin Manager
  Version: 1.0.0 | Updated: 2024/09/23
  Author(s): Erik Riklund

  ?

]]

---@type table<string, plugin>
local plugins = {}

---
--- Registers a new plugin using the provided identifier. This function ensures
--- that each plugin has a unique identifier to prevent conflicts within the system.
---
---@param identifier string "A unique identifier for the plugin."
---
api.createPlugin = function(identifier)
  --
  -- Ensure that the identifier is unique. If a plugin with the same identifier
  -- already exists, we throw an error to prevent accidental overwrites or conflicts.

  if plugins[identifier] ~= nil then
    throwError('Unable to register plugin "%s" (non-unique identifier).', identifier)
  end

  --
  -- Register the plugin by creating an entry in the `plugins` table. The metatable
  -- for the plugin is set to inherit from the base `plugin` class, allowing for
  -- shared behavior between plugins.

  plugins[identifier] = setmetatable({ identifier = identifier }, { __index = plugin })

  --
  -- Return the plugin as a protected proxy to ensure that it cannot be accidentally
  -- modified after registration. This enforces immutability, protecting the integrity
  -- of the plugin's state while still allowing read access.

  return xtable.getProtectedProxy(plugins[identifier])
end

--[[~

  Module: ?
  Version: 1.0.0 | Updated: 2024/09/23

  Provides synchronous and asynchronous task execution. Tasks are queued and processed 
  within a set frame limit to ensure that performance is maintained. Tasks are either 
  executed immediately or added to a task queue for later execution.

]]

---@type task[]
local tasks = {}

---
--- Executes a callback function associated with a given identifier. This function 
--- ensures that the arguments are validated before the callback is executed. If an 
--- error occurs during execution, it is caught and logged for debugging.
---
---@param identifier string    "A unique identifier for the callback."
---@param callback   function  "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
local executeCallback = function(identifier, callback, arguments)
  --
  -- Validate the arguments to prevent errors caused by incorrect types or missing values.

  validateArguments {
    { label = 'identifier', value = identifier, types = 'string' },
    { label = 'callback', value = callback, types = 'function' },
    { label = 'arguments', value = arguments, types = 'array', optional = true },
  }

  --
  -- Execute the callback and capture any exceptions. Using `pcall` ensures that errors 
  -- are caught, preventing crashes and allowing for graceful error handling.

  local success, exception = pcall(callback, unpack(arguments or {}))

  --
  -- If the callback execution fails, log the error for debugging purposes, including 
  -- the identifier to make tracking easier.

  if not success then
    print(('[Backbone] Callback execution failed for "%s":\n%s'):format(identifier, exception))
  end
end

---
--- Queues a callback for asynchronous execution. This allows the system to manage tasks 
--- without blocking the main thread. Tasks are stored in a queue and processed when 
--- the frame limit permits.
---
---@param identifier string    "A unique identifier for the callback."
---@param callback   function  "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
local executeCallbackAsync = function(identifier, callback, arguments)
  --
  -- Add the task to the task queue for asynchronous execution. This defers the task 
  -- to be executed when the frame limit permits, allowing for non-blocking behavior.
  
  table.insert(tasks, { identifier = identifier, callback = callback, arguments = arguments })
end

-- 
-- Creates a coroutine to process tasks. The task queue is processed within a frame 
-- time limit (e.g., 60 frames per second) to ensure the system remains responsive 
-- without overloading the frame execution time.
--
local process = coroutine.create(function()
  local frameLimit = 0.01667 -- 60 FPS limit

  while true do
    local started = GetTime()

    --
    -- Process tasks as long as there are tasks in the queue and the frame limit 
    -- has not been exceeded. This ensures that tasks are executed efficiently 
    -- without impacting performance.

    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as task]]
      executeCallback(task.identifier, task.callback, task.arguments)
    end

    coroutine.yield() -- yield control until the next frame.
  end
end)

-- 
-- Sets up an `OnUpdate` script that checks if there are tasks in the queue and 
-- resumes the coroutine if necessary. This ensures that tasks are processed on
-- every frame update when the queue is not empty.
--
frame:SetScript('OnUpdate', function()
  if #tasks > 0 and coroutine.status(process) == 'suspended' then coroutine.resume(process) end
end)

--[[~

  Component: Listenable
  Version: 1.0.0 | Updated: 2024/09/23

  ?

]]

---@type listenable
local listenable = {
  --
  -- ?

  invokeListeners = function(self, arguments, options) end,

  --
  -- ?

  registerListener = function(self, listener) end,

  --
  -- ?

  removeListener = function(self, identifier) end,
}

---
--- ?
---
---@return listenable "..."
---
local createListenableObject = function()
  return setmetatable({ listeners = {} }, { __index = listenable })
end
