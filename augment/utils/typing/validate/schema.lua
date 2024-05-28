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
--- @param target table
--- @param schema schema
--- @param parent? string
--
--- @return validation_result
--
function _G.validate_schema(target, schema, parent)
  local result = ({ value = target }) --[[@as validation_result]]

  --
  --- ???
  --
  --- @return string
  --
  local function fail(key, message, ...)
    return ('@root%s/%s: %s'):format(parent or '', key, ... and message:format(...) or message)
  end

  -- check for invalid properties
  for key, _ in pairs(target) do
    if schema[key] == nil then
      result.error = fail(key, "Unexpected property, please verify your schema")
      print(result.error)
    end
  end

  if not result.error then
    --- @type validation_result
    local validation_result

    for key, property in pairs(schema) do
      if type(property.type) == 'table' then
        -- nested schema validation
        if type(target[key]) ~= 'table' then
          validation_result = validate_type(target[key], { type = 'table' })
        else
          validation_result = validate_schema(
            target[key], property.type --[[@as schema]], (parent or '') .. '/' .. key
          )
        end
      else
        -- simple type validation
        validation_result = validate_type(target[key], property --[[@as property]])
      end

      if validation_result.error then
        result.error = validation_result.error -- TODO fix the property path output for nested schemas!
        print(result.error)
        break -- abort the rest of the process
      end
    end
  end

  return result
end
