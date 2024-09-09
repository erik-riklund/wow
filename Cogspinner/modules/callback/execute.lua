--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

--- @type callbacks.executeCallbackAsync
local executeCallbackAsync = framework.import('callback/execute-async')

--
-- Invokes the given callback function, optionally with arguments,
-- either immediately or asynchronously (default behavior).
--
--- @type callbacks.executeCallback
--
local executeCallback = function(callback, arguments, options)
  if not options or (options and options.async ~= false) then
    executeCallbackAsync(callback, arguments or {})
  else
    -- ~ Executes the callback synchronously and handles potential errors.
    local success, result = pcall(callback, unpack(arguments or {}))

    if not success then
      -- todo: implement error reporting.
    end
  end
end

---
--- Expose the function to the framework context.
---
framework.export('callback/execute', executeCallback)
