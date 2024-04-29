local ADDON, CORE = ...
local EventHandler = CORE.EventHandler
local Events = EventHandler.Events
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
--- Registers a callback function as a listener for a specified event.
--
-- @param event string The name of the event to listen for.
-- @param callback function The function to be called when the event is triggered.
--

Listen = function(event, callback)
  EventHandler:Listen(event, callback)
end

--
--- Registers a callback function to be executed when a specified event occurs.
--
-- This function handles event listener registration, with special logic for the 
-- 'ADDON_LOADED' event and managing subscriptions for standard Blizzard events.
--
-- @param event string The name of the event to listen for.
-- @param callback function The function to be called when the event is triggered.
-- @throws error If attempting to register a listener for the 'ADDON_LOADED' event using this function
--

function EventHandler:Listen(event, callback)
  --
  if event == "ADDON_LOADED" then
    error("Listener registration for the 'ADDON_LOADED' event must be done with the `OnLoad` function")
  end

  if Events.Blizzard[event] then
    --
    if not self.Subscriptions[event] then
      --
      self.Reciever:RegisterEvent(event)
      self.Subscriptions[event] = true
    end
  end

  self.Listeners[event] = self.Listeners[event] or {}
  table.insert(self.Listeners[event], callback)
end
