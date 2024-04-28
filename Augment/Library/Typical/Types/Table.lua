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
--- Creates a validator function for checking table types (potentially including empty arrays).
--
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated.
--   * `value` (any): The value to validate.
--     @return boolean true if the value is a table or potentially an empty array, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (table): The validated table (or potentially an empty array).
--       * `error` (string): An error message if the validation failed.
--

function Type:Table()
  return function(property, value)
    --
    local actual_type = self:GetType(value)

    -- check if table or empty array (which are indistinguishable)
    if actual_type ~= "table" and not (actual_type == "array" and #value == 0) then
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

    return true, {value = value}
  end
end
