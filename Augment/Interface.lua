local ADDON, CORE = ...

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

CORE.EventHandler = {
  --
  -- Contains lists of standard and framework-specific events,
  -- used to block invocation of internal events from plugins.
  --
  Events = {Framework = {}, Plugins = {}},
  --
  -- Used to store callback functions registered for events.
  --
  Listeners = {},
  --
  -- Used to keep track of which events the event reciever is subscribed to.
  --
  Subscriptions = {},
  --
  -- The frame used to listen for standard events.
  --
  Reciever = CreateFrame("Frame")
}

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

CORE.LocaleHandler = {
  --
  --
  --
  Locale = GetLocale(),
  --
  -- Used to store references to the registered locales for plugins.
  --
  Strings = {}
}

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

CORE.PluginManager = {
  --
  -- Used to store references to each registered plugin's context.
  --
  Plugins = {}
}

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

CORE.ServiceHandler = {
  --
  -- The internal registry used to keep track of registered services.
  --
  Services = {}
}
