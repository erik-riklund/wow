local ADDON, CORE = ...

--
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
local Object = CORE.Object -- create a local reference
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Frame ]
--
-- ???
--
CORE.Frame = CreateFrame("Frame")

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

CORE.Data = {
  --
  Structures = {
    --
    --[ Map ]
    --
    -- ???
    --
    Map = Object:Extend("Map"),
    --
    --[ Array ]
    --
    -- ???
    --
    Array = Object:Extend("Array")
  },
  --
  Primitive = {
    --
    --[ Number ]
    --
    -- ???
    --
    Number = Object:Extend("Number")
  }
}

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

CORE.Utils = {
  --
  --[ Type ]
  --
  -- The type-checking library used by the framework to enforce
  -- strict parameter types and enable schema-based validation.
  --
  TypeChecker = Object:Extend("TypeChecker", "static"),
  --
  --[ Markup ]
  --
  -- ???
  --
  MarkupParser = Object:Extend("MarkupParser", "static")
}

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

CORE.Events = {
  --
  --[ Listeners ]
  --
  -- ???
  --
  Listeners = Object:Extend("EventListenerManager", "static"),
  --
  --[ Subscriptions ]
  --
  -- ???
  --
  Subscriptions = Object:Extend("EventSubscriptionHandler", "static")
}
