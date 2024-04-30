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
--- Creates a validator function that allows a value to be either of a specified type or undefined (nil).
--
-- This is useful for representing optional parameters or properties.
--
-- @param expected_type function A validator function (e.g., created using `Type:String`).
-- @return function A validator function that accepts the specified type or `nil`.
--

function Type:Optional(expected_type)
  return self:FirstOf({expected_type, self:Undefined()})
end

--
--- Creates a validator function that accepts any type of value.
---
--- This function is the opposite of `Type:Undefined`. It's useful when you need maximum
--- flexibility in the types you allow.
---
--- @param default_value any (optional) This parameter is not used by the validator.
--- @return function A validator function that returns true for all values (not nil).
--

function Type:Any(default_value)
  return self:Not(self:Undefined())
end

--
--- Creates a validator function that performs a flexible or "partial" validation against a schema.
--
-- This function allows for missing properties in the validated object compared to the schema
-- and only checks for the existence and type correctness of properties that are present.
--
-- @param schema table A table defining the schema. Keys represent expected keys in the 
--                  target table.  Values associated with these keys should be type 
--                  validator functions (e.g., created using `Type:String`).
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated (top-level table key).
--   * `target` (table): The table to validate against the schema.
--     @return boolean True if the table partially matches the schema, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (table): The validated table (potentially with unmatched properties removed).
--       * `error` (string): An error message if any properties failed validation.
--

function Type:Partial(schema)
  return self:Schema(schema, true)
end

--
--- Creates a validator function that accepts a value if it passes any of the provided validators.
--
-- This function is useful for defining flexible validation rules where multiple types
-- might be acceptable for a single property.
--
-- @param expected_types table An array of type validator functions (e.g., created using 
--                            `Type:String`, `Type:Number`).
--
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated.
--   * `value` (any): The value to validate.
--     @return boolean true if the value passes at least one of the provided validators, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (any, optional): The validated value.
--       * `actual_type` (string): The detected type of the value.
--       * `expected_type` (string): A string representing the allowed types from the provided validators.
--       * `error` (string): An error message if the validation failed for all validators. 
--

function Type:FirstOf(expected_types)
  --
  local valid = (self:Array(self:Function())(expected_types, expected_types))

  if not valid then
    Throw("Expected an array of type validators for parameter 'expected_types'")
  end

  return function(property, value)
    --
    local checked_types = {}

    for _, validator in ipairs(expected_types) do
      --
      local success, result = validator(property, value)

      if success then
        return success, result -- passed!
      end

      table.insert(checked_types, result.expected_type)
    end

    return false, {
      error = Catch(
        Error.INVALID_TYPE,
        {
          property = property,
          actual_type = self:GetType(value),
          expected_type = table.concat(checked_types, "` or `")
        }
      )
    }
  end
end

--
--- Creates a validator function that accepts any value except those matching a specified excluded type.
--
-- This function is a powerful tool for defining validation rules based on the exclusion
-- of certain types.
--
-- @param excluded_type function A validator function (e.g., created using `Type:Number`).
--
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated.
--   * `value` (any): The value to validate.
--     @return boolean true if the value does NOT match the excluded type, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (any, optional): The validated value.
--       * `actual_type` (string): The detected type of the input value.
--       * `expected_type` (string): The negated name or representation of the excluded type.
--       * `error` (string): An error message if the value matched the excluded type.
--

function Type:Not(excluded_type)
  --
  if self:GetType(excluded_type) ~= "function" then
    Throw("Expected a type validator for parameter 'excluded_type'")
  end

  return function(property, value)
    local success, result = excluded_type(property, value)
    return (not success), result
  end
end
