local ADDON, CORE = ...
local EventHandler = CORE.EventHandler

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
--- Registers a callback function to be executed specifically when the 'ADDON_LOADED' event occurs.
--
-- This function handles the registration of 'ADDON_LOADED' event listeners and ensures
-- necessary subscriptions for this event. It associates callbacks with specific addon names.
--
-- @param addon string The name of the addon.
-- @param callback function The function to be called when the 'ADDON_LOADED' event is triggered.
--

OnLoad = function(addon, callback)
  --
  if not EventHandler.Subscriptions["ADDON_LOADED"] then
    --
    EventHandler.Reciever:RegisterEvent("ADDON_LOADED")
    EventHandler.Subscriptions["ADDON_LOADED"] = true
  end

  EventHandler.Listeners["ADDON_LOADED"] = EventHandler.Listeners["ADDON_LOADED"] or {}
  EventHandler.Listeners["ADDON_LOADED"][addon] = callback
end

--
--- Executes the callback function registered for a specific addon's 'ADDON_LOADED' event, if one exists.
--
-- @param addon string The name of the addon.
--

function EventHandler:OnLoad(addon)
  --
  local callback = EventHandler.Listeners["ADDON_LOADED"][addon]
  
  if callback then callback() end
end
