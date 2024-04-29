local ADDON, CORE = ...
local ServiceHandler = CORE.ServiceHandler

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

Listen(
  "PLUGIN_ADDED",
  --
  function(plugin)
    --
    function plugin:AddService(id, service)
      ServiceHandler:AddService(id, service)
    end
    --
    function plugin:GetService(id)
      return ServiceHandler:GetService(id)
    end
  end
)
