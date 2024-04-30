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
--- Creates a validator for record-like tables with specific key and value types.
--
-- This validator enforces a structure where all keys must conform to a specified
-- key type, and all values must conform to a specified value type.
--
-- @param property_type function A validator function for checking keys (e.g., created using `Type:String`).
-- @param value_type function A validator function for checking values (e.g., created using `Type:Number`).
--
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated.
--   * `target` (table): The table to validate.
--     @return boolean true if the record is valid, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (table): The validated record.
--       * `error` (string): An error message if the validation failed.
--

function Type:Record(property_type, value_type)
  --
  if self:GetType(property_type) ~= "function" then
    Throw("Expected a type validator for parameter 'property_type'")
  end

  if self:GetType(value_type) ~= "function" then
    Throw("Expected a type validator for parameter 'value_type'")
  end

  return function(property, target)
    --
    local actual_type = self:GetType(target)

    -- check if table or empty array (which are indistinguishable)
    if actual_type ~= "table" and not (actual_type == "array" and #target == 0) then
      --
      return false, {
        error = Catch(
          Error.INVALID_TYPE,
          {
            property = property,
            actual_type = actual_type,
            expected_type = "table"
          }
        )
      }
    end

    for key, value in pairs(target) do
      --
      local key_success, key_result = property_type(key, key)

      if not key_success then
        --
        return false, {
          error = Catch(
            Error.INVALID_KEY_TYPE,
            {
              property = key,
              actual_type = key_result.actual_type,
              expected_type = key_result.expected_type
            }
          )
        }
      end

      --
      local value_success, value_result = value_type(key, value)

      if not value_success then
        --
        return false, {
          error = Catch(
            Error.INVALID_TYPE,
            {
              property = key,
              actual_type = value_result.actual_type,
              expected_type = value_result.expected_type
            }
          )
        }
      end
    end

    return true, {value = target}
  end
end
