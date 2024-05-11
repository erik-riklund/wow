local ADDON, Framework = ...

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

--
--[ EventHandler ]
--
-- ???
--
Framework.EventHandler = {
  --
  --[ _subscriptions ]
  --
  -- ???
  --
  _subscriptions = Array:Create("string"),
  --
  --[  ]
  --
  -- ???
  --
  _listeners = Map:Create("string", "array(function)"),
  --
  --[ Listen ]
  --
  -- ???
  --
  Listen = function(self)
    print("Listen - not implemented")
  end,
  --
  --[ Dispatch ]
  --
  -- ???
  --
  Dispatch = function(self)
    print("Dispatch - not implemented")
  end
}

--
--[ OnLoad ]
--
-- ???
--
OnLoad = function(addon, callback)
  print("OnLoad - not implemented")
end
