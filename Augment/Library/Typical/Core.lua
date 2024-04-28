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
--- Enforces type safety for a parameter, optionally throwing errors.
--
-- This function is a core part of your type-checking system. It uses a provided
-- validator to check the type of a parameter. If type-checking is enabled (`self.Enabled`)
-- and the validation fails, an error is thrown.
--
-- @param name string The name of the parameter.
-- @param value any The value to validate.
-- @param validator function A validator function, created using one of the validator
--                           generator functions (e.g., `Type:String`, `Type:Number`).
-- @return any The validated value (potentially modified during validation).
-- @throws error Throws an error if the validation fails and type-checking is enabled.
--

function Type:Check(parameter, value, validator)
  --
  if self.Enabled then
    --
    if self:GetType(parameter) ~= "string" then
      Throw("Expected type string for parameter 'parameter'")
    end

    if self:GetType(validator) ~= "function" then
      Throw("Expected a type validation function for parameter 'validator'")
    end

    local success, result = validator(parameter, value)

    if not success then
      Throw(result.error)
    end

    return result.value
  end

  return value -- when type-checking is disabled
end

--
--- Determines the detailed type representation of an input value.
--
-- This function provides a more nuanced type categorization than Lua's built-in
-- 'type' function, distinguishing between arrays and general tables.
--
-- @param input any The value to be type-checked.
-- @return string A string representing the determined type:
--   * "undefined" (if the input is nil)
--   * The standard Lua type name (e.g., "number", "string", "boolean")
--   * "array" (for numerically indexed tables)
--   * "table" (for general tables with associative keys)
--

function Type:GetType(input)
  --
  local input_type = type(input)

  if input_type == "nil" then
    return "undefined"
  elseif input_type ~= "table" then
    return input_type
  end

  local is_empty = next(input) == nil
  local entry_count = Table:KeyCount(input)
  local numeric_indexes = #input

  return ((is_empty or entry_count == numeric_indexes) and "array") or "table"
end

--
--- Creates a validator function to check a value's type against an expected type.
--
-- @param expected_type string The expected type (e.g., "string", "number", "array", "table").
-- @param default_value any (optional) A default value to use if the original value is nil.
--
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated.
--   * `value` (any): The value to validate.
--     @return boolean true if the value's type matches the expected type, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (any): The validated value (or the default if the original value was nil)
--       * `actual_type` (string):  The detected type of the value.
--       * `expected_type` (string): The expected type.
--       * `error` (string): An error message if the validation failed.
--

function Type:Validator(expected_type, default_value)
  return function(property, value)
    --
    local result = {
      value = value or default_value,
      actual_type = self:GetType(value or default_value),
      expected_type = expected_type
    }

    local success = (result.actual_type == result.expected_type)

    if not success then
      result.error =
        Catch(
        Error.INVALID_TYPE,
        {
          property = property,
          actual_type = result.actual_type,
          expected_type = result.expected_type
        }
      )
    end

    return success, result
  end
end
