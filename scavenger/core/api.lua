--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/core (2026)

local x = select(2, ...)

--
-- Acts as the internal registry for all public-facing methods.
--
-- Features an 'extend' method that allows external modules or
-- other addons to safely register their own custom callbacks.
--

x.api = {
  --
  -- Safely registers a new method in the API table, ensuring we don't
  -- overwrite existing features or accept invalid, non-executable data.

  extend = function(key, callback)
    if x.api[key] ~= nil then
      error("Attempt to overwrite an existing API key: " .. key, 2)
    elseif type(callback) ~= "function" then
      error("The callback must be a function", 2)
    else
      x.api[key] = callback -- Successfully register the new function.
    end
  end
}

--
-- Exposes a read-only interface to the global environment.
--
-- This allows external modules and other addons to access the API while
-- protecting our core tables from accidental modification or deletion.
--

_G.scavenger = setmetatable(
  {}, {
    --
    -- Intercepts reads. If an external script requests `scavenger.some_function`,
    -- we look it up and return it from our validated internal API registry.

    __index = function(_, key)
      if x.api[key] == nil then
        scavenger.warn("The requested API key '%s' does not exist", key)
      else
        return x.api[key] -- Return the requested function.
      end
    end,

    -- Intercepts writes. If an external script tries to assign or overwrite a
    -- value directly (e.g., `scavenger.foo = bar`), this block catches and
    -- ignores it to keep the globally accessible API read-only.

    __newindex = function()
      scavenger.error("Direct writes blocked, use 'scavenger.extend'")
    end
  }
)
