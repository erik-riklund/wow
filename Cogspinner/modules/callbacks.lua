--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework       = ...

local exception              = _G.exception
local pcall                  = _G.pcall
local type                   = _G.type
local unpack                 = _G.unpack

local registerBackgroundTask = framework.import('core/tasks') --[[@as BackgroundTaskHandler]]

--
-- This function executes a callback function, either synchronously or asynchronously,
-- while providing support for passing arguments and basic error handling.
--
--- @type CallbackHandler
--
local executeCallback        = function(callback, arguments, options)
  options = options or {}

  --~ We ensure that the provided callback and options (if provided) are valid.

  if type(callback) ~= 'function' then
    exception('Invalid argument type for "callback". Expected a function.')
  end

  if options and type(options) ~= 'table' then
    exception('Invalid argument type for "options". Expected a table (or nil).')
  end

  if arguments and type(arguments) ~= 'table' then
    exception('Invalid argument type for "arguments". Expected a table (or nil).')
  end

  if type(options.async) ~= 'nil' then
    if type(options.async) ~= 'boolean' then
      exception('Invalid argument type for "options.async". Expected a boolean (or nil).')
    end
  end

  --~ Asynchronous execution:
  --~ If 'async' is true or not provided (defaulting to asynchronous), we queue the callback
  --~ for background execution. This may prevent long-running or potentially blocking operations
  --~ from impacting the main thread, causing UI freezes or performance issues.

  if options.async == nil or options.async == true then
    registerBackgroundTask(callback, arguments)
  end

  --~ Synchronous execution
  --~ If 'async' is explicitly set to false, we execute the callback immediately on the current
  --~ thread. This is useful for short, non-blocking operations or when immediate results are required.

  if options.async == false then
    local success, result = pcall(callback, unpack(arguments or {}))

    if not success then
      -- todo: how do we want to handle error reporting?
    end
  end
end

--
-- Exports the callback handler, allowing other modules to execute
-- callbacks in a controlled and flexible manner.
--
framework.export('module/callbacks', executeCallback)
