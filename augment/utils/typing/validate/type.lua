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
--

--
--- Checks if a given value adheres to a specified type definition. If the value matches
--- the expected type, it returns the value (potentially with a default applied).
--
--- If the value does not match, it returns an error message indicating the mismatch.
--
--- @param value any
--- @param options argument
--
--- @return validation_result
--
function _G.validate_type(value, options)
  local result = ({ value = value or options.default } --[[@as validation_result]])
  local actual_type = examine(result.value)
  local expected_type = options.type --[[@as string]]

  --
  -- These nested `if` statements perform the following logic:
  --
  -- 1. Check if the value is provided (not `nil`) OR the parameter is not optional. If so,
  --    and the actual type does NOT match the expected type, proceed to the next check.
  -- 2. Handle the special case of the `any` type:
  --    * If the expected type is NOT `any`, proceed to the next check.
  --    * If the expected type IS `any`, but the actual value is `nil` (undefined), proceed
  --      to the next check.
  -- 3. Handle table-like types (`list` and `map`):
  --    * If the expected type is NOT `list` or `map`, OR the actual type is NOT `table`,
  --      then the types are mismatched. An error message will be generated indicating
  --      the expected and actual types.
  --
  -- If none of these conditions trigger an error, the validation passes, and the value
  -- (or its default) is considered valid.
  --

  if (value ~= nil or options.optional ~= true) and actual_type ~= expected_type then
    if expected_type ~= 'any' or expected_type == 'any' and actual_type == 'undefined' then
      if not ((expected_type == 'list' or expected_type == 'map') and actual_type == 'table') then
        result.error = ("Expected a value of type `%s` but recieved `%s`"):format(expected_type, actual_type)
      end
    end
  end

  return result
end
