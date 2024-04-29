local ADDON, CORE = ...
local EventHandler = CORE.EventHandler
local Events = EventHandler.Events

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

EventHandler.Reciever:SetScript(
  "OnEvent",
  --
  function(self, event, ...)
    --
    local args = ...

    Switch(
      event,
      {
        ADDON_LOADED = function()
          EventHandler:OnLoad(args)
        end,
        --
        default = function()
          EventHandler:Dispatch(event, args)
        end
      }
    )
  end
)

--
--- Prevents triggering of restricted standard game events and internal framework events.
--
-- @param event string The name of the event to check.
-- @throws error If the event is found within the restricted event lists. The error
--               message includes the name of the restricted event.
--

function EventHandler:NotRestricted(event)
  --
  if Events.Blizzard[event] then
    Throw("The standard game event '$event' cannot be triggered manually", {event = event})
  end

  if Events.Framework[event] then
    Throw("The internal framework event '$event' cannot be triggered manually", {event = event})
  end

  return true
end
