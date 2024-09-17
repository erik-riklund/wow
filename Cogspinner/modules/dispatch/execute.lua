--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

--- @type dispatch.executeCallbackAsync
local executeCallbackAsync = framework.import('dispatch/execute-async')

---
--- A dispatcher function providing a unified interface for callback execution,
--- with support for both synchronous and asynchronous modes, including built-in
--- error handling for synchronous calls.
---
--- @type dispatch.executeCallback
---
local executeCallback = function(callback, arguments, options)
  if not options or (options and options.async ~= false) then
    executeCallbackAsync(callback, arguments or {})
  else
    -- Executes the callback synchronously and handles potential errors.
    local success, result = pcall(callback, unpack(arguments or {}))

    if not success then
      -- todo: implement error reporting.
    end
  end
end

--
framework.export('dispatch/execute', executeCallback)
