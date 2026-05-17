--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

--
-- # Event registration & dispatcher frame
--
-- Sets up an internal registry for event callbacks and
-- creates an invisible frame to listen for specific game events.
--

local event_hooks = {}
local event_frame = CreateFrame("Frame")

event_frame:RegisterEvent("ADDON_LOADED")
event_frame:RegisterEvent("LOOT_OPENED")
event_frame:RegisterEvent("LOOT_CLOSED")
event_frame:RegisterEvent("LOOT_SLOT_CLEARED")

--
-- # Trigger internal listeners
--
-- Executes all registered callback functions associated with a given event.
-- Passes any arguments received straight to the hooks.
--

x.invoke_listeners = function(event_name, ...)
  if event_hooks[event_name] ~= nil then
    for _, callback in ipairs(event_hooks[event_name]) do
      if type(callback) == "function" then
        callback(...) -- invoke each hook in the order they were registered.
      end
    end
  end
end

--
-- # Game event dispatcher script
--
-- The master event listener. It catches raw game events and
-- routes them into the internal callback system.
--

event_frame:SetScript(
  "OnEvent", function(_, event_name, ...)
    if event_name == "ADDON_LOADED" then
      local addon_name = ...
      if addon_name ~= "Scavenger" then
        return -- Ignore when other addons load; we only care when Scavenger is ready.
      end
    end

    x.invoke_listeners(event_name, ...)
  end
)

--
-- # API: Register event hooks
--
-- Exposes a function to let other files or addons hook into events.
-- It returns a cleanup function so the caller can easily unhook themselves later.
--

scavenger.extend(
  "add_event_hook", function(event_name, callback)
    if not event_hooks[event_name] then
      event_hooks[event_name] = {}
    end
    table.insert(event_hooks[event_name], callback)

    -- Return an unregister/disconnect function.
    -- Calling it will cleanly remove the registered callback.

    return function()
      for index, hook in ipairs(event_hooks[event_name]) do
        if hook == callback then
          table.remove(event_hooks[event_name], index)
          break -- Exit early now that the target hook is found and removed.
        end
      end
    end
  end
)
