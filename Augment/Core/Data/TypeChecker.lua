local ADDON, CORE = ...
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
local Packages, Object = CORE.Packages, CORE.Object
local TypeChecker = Packages:Add("Core.Data", Object:Extend("TypeChecker", "static"))
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ TypeChecker:Check ]
--
-- ???
--
function TypeChecker:Check(property, value, validator)
  --
  if type(property) ~= "string" then
    error("Expected type `string` for parameter 'property'")
  end
  --
  local validation_type = type(validator)
  if validation_type ~= "string" and validation_type ~= "function" then
    error("Expected type `string` or `function` for parameter 'validator'")
  end
  --
  local success, result = pcall(self:GetValidator(validator), property, value)
  return (success and result) or error(result)
end

--
--[ TypeChecker:Inspect ]
--
-- Determine the data type of the provided value.
--
function TypeChecker:Inspect(value)
  --
  local value_type = type(value)
  --
  return Switch(
    value_type,
    {
      ["nil"] = "undefined",
      --
      table = function()
        return (value.GetType and value:GetType()) or "table"
      end,
      --
      default = value_type
    }
  )
end

--
--[ TypeChecker:GetValidator ]
--
-- ???
--
function TypeChecker:GetValidator(expected_type)
  --
  if type(expected_type) == "function" then
    return expected_type -- no work required, simply return the function
  end
  --
  if type(expected_type) ~= "string" then
    error("Expected type `string` for parameter 'expected_type'")
  end
  --
  
end
