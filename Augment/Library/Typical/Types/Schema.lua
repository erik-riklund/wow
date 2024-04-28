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

    return true, {value = target} -- < debug
  end
end
