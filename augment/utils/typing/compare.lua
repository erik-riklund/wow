local examine, type = _G.examine, _G.type
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
--- ???
--
--- @param target table<string, any>
--- @param schema schema
--- @param parent? string
--
--- @return compare_result
--
local function compare_schema(target, schema, parent)
  --
  -- 1: 

  return { success = true }
end

--
--- ???
--
--- @param value any
--- @param expected_type string|schema
--
--- @return compare_result
--
_G.compare = function(value, expected_type)
  --
  -- 1: Determine the validation complexity

  if type(expected_type) == 'table' then
    --
    -- 1.1: Perform schema validation

    local result = compare_schema(value, expected_type)

    if result.success == false then
      return result -- validation failed
    end
  else
    --
    -- 1.2: Simple type validation

    local actual_type = examine(value)

    if actual_type ~= expected_type then
      return {
        success = false,
        error = string.format(
          "Expected type `%s`, recieved `%s`", actual_type, expected_type
        )
      }
    end
  end

  --
  -- 2: All done, no errors!

  return { success = true }
end

local r = compare('', {
  alpha = property.required('string'),
  beta = property.required('number'),
  charlie = property.optional('string', 'Hello world')
})

print(r.error)
