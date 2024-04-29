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
--- Creates a validator function for enforcing schemas on tables. 
--
-- This function allows you to define complex validation rules for table structures, 
-- including the types of individual keys and their corresponding values.
--
-- @param schema table A table defining the schema. Keys in the schema represent 
--                  expected keys in the target table.  Values associated with these 
--                  keys should be type validator functions (e.g., created using `Type:String`).
--
-- @return function A validator function with the following signature:
--   * `property` (string): The name of the property being validated (top-level table key).
--   * `target` (table): The table to validate against the schema.
--     @return boolean true if the table matches the schema, false otherwise.
--     @return table Additional details about the validation:
--       * `value` (table): The validated table (potentially modified).
--       * `error` (string): An error message if the validation failed.
--

function Type:Schema(schema)
  --
  local schema = schema or {}
  local schema_type = self:GetType(schema)

  return function(property, target)
    --
    if type(target) ~= "table" then
      --
      return false, {
        error = Catch(
          Error.INVALID_TYPE,
          {
            property = property,
            actual_type = type(target),
            expected_type = "table"
          }
        )
      }
    end

    for key, validator in pairs(schema) do
      --
      local success, result = validator(key, target[key])

      if not success then
        --
        Debug:Inspect(result)
        return false, {
          error = Catch(
            Error.INVALID_TYPE,
            {
              property = key,
              actual_type = result.actual_type,
              expected_type = result.expected_type
            }
          )
        }
      end

      target[key] = result.value
    end

    for key, value in pairs(target) do
      -- check for invalid keys!
    end

    return true, {value = target}
  end
end
