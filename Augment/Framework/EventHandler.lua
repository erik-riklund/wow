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
local Type, Map, Array = Import({"Core.TypeHandler", "Core.Types.Map", "Core.Types.Array"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ EventHandler ]
--
-- ???
--
Framework.EventHandler = {
  --
  --[ _frame ]
  --
  -- ???
  --
  _frame = nil,
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
  Listen = function(self, event, callback)
    local event, callback = Type:Is("string", event), Type:Is("function", callback)

    -- ???
  end,
  --
  --[ Dispatch ]
  --
  -- ???
  --
  Dispatch = function(self, event, ...)
    local event = Type:Is("string", event)

    -- ???
  end
}

--
--[ OnLoad ]
--
-- ???
--
OnLoad = function(addon, callback)
end
