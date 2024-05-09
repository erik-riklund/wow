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
local Frame, Events = CORE.Frame, CORE.Events
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

Frame:SetScript(
  "OnEvent",
  --
  function(self, event, ...)
    --
    if event == "ADDON_LOADED" then
      return Events:OnLoad(...)
    end
    --
    Events:Dispatch(event, ...)
  end
)

--
--[ OnLoad ]
--
-- ???
--
OnLoad = function(addon, callback)
  print("OnLoad - not implemented")
end
