local ADDON, CORE = ...
local EventHandler = CORE.EventHandler
local T = Type

--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--- Conditionally dispatches an event to the EventHandler, preventing restricted events.
--
-- This function acts as a gatekeeper, first checking if the event is restricted. If the
-- event is allowed, it forwards the dispatch call to the internal `EventHandler:Dispatch`
-- function.
--
-- @param plugin table The plugin context from which the event is dispatched.
-- @param event string The name of the event to dispatch.
-- @param ... Additional arguments to pass to the event handler.
--

Dispatch = function(plugin, event, ...)
  --
  if EventHandler:IsInvokable(plugin, event) then
    EventHandler:Dispatch(event, ...)
  end
end

--
--- Triggers event listeners associated with the given event name.
--
-- This function iterates through the listeners for a specific event
-- and executes each callback function.
--
-- @param event string The name of the event to trigger.
-- @param ... Additional arguments to pass to the event listener callbacks.
--

function EventHandler:Dispatch(event, ...)
  --
  if T:GetType(self.Listeners[event]) == "array" then
    --
    for _, callback in ipairs(self.Listeners[event]) do
      callback(...)
    end
  end
end
