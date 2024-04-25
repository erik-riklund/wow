local ADDON, CORE = ...
local Type = Type
local Error = Type.Errors

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

function Type:GetType(input)
  local input_type = type(input)

  if input_type ~= "table" then
    return input_type
  end

  -- determine if table or array
end

function Type:Param(name, value, callback)
  return callback("parameter", name, value)
end

function Type:Schema()
  print("NOT IMPLEMENTED - Type:Schema()")
end

function Type:Validator(expected_type, default_value)
  return function(validation_type, key, value, quiet)
    local quiet = quiet or false

    local result = {
      value = value or default_value,
      actual_type = self:GetType(value or default_value),
      expected_type = expected_type
    }

    -- TODO > add extra check for empty tables, which will be typed as arrays!

    if result.actual_type ~= result.expected_type then
      if not quiet then
        self:Error(Error.INVALID_TYPE, result.expected_type, validation_type, key, result.actual_type)
      end

      return result
    end

    return result.value
  end
end
