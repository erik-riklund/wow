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
--- Acts as an inspector, rigorously checking a data structure (table) to ensure it conforms
--- to a predefined blueprint (schema). If the structure matches the blueprint, it returns the
--- potentially modified structure; otherwise, it reports the first encountered discrepancy.
--
--- @param target table
--- @param schema schema
--- @param parent? string
--
--- @return validation_result
--
function _G.validate_schema(target, schema, parent)
  local result = ({ value = target }) --[[@as validation_result]]

  --
  --- @param key? string
  --- @param message string
  --- @vararg string|number ...
  --
  --- @return string
  --
  local function fail(key, message, ...)
    return ('@root%s%s: %s'):format(
      parent or '', key and ('/' .. key) or '', ... and message:format(...) or message
    )
  end

  if type(target) ~= 'table' then
    result.error = fail(nil, "Expected a value of type `table` but recieved `%s`", type(target))
  end

  if not result.error then
    for key, _ in pairs(target) do
      if schema[key] == nil then -- invalid property!
        result.error = fail(nil, "Unexpected property '%s', please verify your schema", key)
      end
    end
  end

  if not result.error then
    --- @type validation_result
    local validation_result

    for key, property in pairs(schema) do
      if type(property.type) == 'table' then -- nested schema
        validation_result = validate_schema(
          target[key], property.type --[[@as schema]], ('%s/%s'):format(parent or '', key)
        )
      else -- simple type validation
        validation_result = validate_type(target[key], property --[[@as property]])
      end

      if validation_result.error then
        local append_path = string.sub(validation_result.error, 1, 1) ~= '@'
        result.error = append_path and fail(key, validation_result.error) or validation_result.error

        break -- abort the rest of the process
      end

      target[key] = validation_result.value
    end
  end

  return result
end
