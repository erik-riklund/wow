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
--- Creates a validator function specifically for enforcing array types and validating element types.
--
-- This function ensures that the value is an array and (optionally) uses the provided type validation
-- function to check the type of each array element.
--
-- @param expected_type function A type validator function (e.g., created using `Type:String`).
--
-- @return function A validator function with the following signature:
--     * `property` (string): The name of the property being validated.
--     * `value` (any):  The value to validate.
--     @return boolean true if the value is a valid array, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (array, optional): The validated array.
--       * `error` (string): An error message if the validation failed.
--

function Type:Array(expected_type)
  --
  local strict_type = (self:GetType(expected_type) == "function")

  return function(property, value)
    --
    local actual_type = self:GetType(value)

    if actual_type ~= "array" then
      --
      return false, {
        error = Catch(
          Error.INVALID_TYPE,
          {
            property = property,
            actual_type = actual_type,
            expected_type = "array"
          }
        )
      }
    end

    if strict_type then
      for index, content in ipairs(value) do
        --
        local success, result = expected_type(index, content)

        if not success then
          return false, result
        end
      end
    end

    return true, {value = value}
  end
end
