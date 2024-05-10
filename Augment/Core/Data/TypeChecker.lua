local ADDON, CORE = ...
local Packages, Object = CORE.Packages, CORE.Object
local error, type = error, type

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
local TypeChecker = Packages:Add("Core.Data", Object:Extend("TypeChecker", "static"))
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ TypeChecker:Inspect ]
--
-- ???
--
function TypeChecker:Inspect(value)
  local actual_type = type(value)

  return Switch(
    actual_type,
    {
      default = actual_type,
      ["nil"] = "undefined",
      --
      table = function()
        return (value.GetType and value:GetType()) or "table"
      end
    }
  )
end
