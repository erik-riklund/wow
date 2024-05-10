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

--
--[ TypeChecker:Check ]
--
-- ???
--
function TypeChecker:Check(value, options)
  local expected_type, default_value = Destructure(options, {"type", "default"})
  local validator = self:GetValidator(expected_type)

  
end

--
--[ TypeChecker:GetValidator ]
--
-- ???
--
function TypeChecker:GetValidator(expected_type)
  if type(expected_type) ~= "string" then
    error("Expected type `string` for parameter 'expected_type'")
  end

  return function(value)
    return self:Inspect(value) == expected_type
  end
end
