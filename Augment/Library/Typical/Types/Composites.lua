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

local Type = Type
local Error = Type.Errors

--

--

function Type:Optional(expected_type)
  return self:FirstOf({expected_type, self:Undefined()})
end

--

--

function Type:Any(default_value)
  return self:Not(self:Undefined())
end

--

--

function Type:FirstOf(expected_types)
  --
  local valid = (self:Array(self:Function())(expected_types, expected_types))

  if not valid then
    Throw("Expected an array of type validators for parameter 'expected_types'")
  end

  return function(property, value)
    --

    -- TODO > IMPLEMENT THIS!
    
    return true, {value = value}
  end
end

--

--

function Type:Not(excluded_type)
  --
  if self:GetType(excluded_type) ~= "function" then
    Throw("Expected a type validator for parameter 'excluded_type'")
  end

  return function(property, value)
    --
    local undefined, result = excluded_type(property, value)
    return not undefined, result
  end
end
