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

local catch, typeof, switch, pairs =
    _G.catch, _G.typeof, _G.switch, _G.pairs

--
--- ???
--
--- @param param {type: string, default: any, optional: boolean?}
--
local validate_simple = function(value, param)
  value = value or param.default
  local actual_type = typeof(value)

  if (actual_type == "undefined" and not param.optional) or
      (param.type ~= "any" and param.type ~= actual_type and not (actual_type == "undefined" and param.optional)) then
    return { error = catch("Expected type `%s`, recieved `%s`", param.type, actual_type) }
  end

  return { value = value }
end

--
--- ???
--
--- @
--
local validate_multiple = function(value, param)
  local types = param.type
  local types_n = #types

  local types_checked = {}

  for i = 1, types_n do
    local result =
        validate_simple(
          value,
          {
            type = types[i],
            default = param.default,
            optional = param.optional
          }
        )

    if not result.error then
      return { value = result.value }
    end

    table.insert(types_checked, types[i])
  end

  return {
    error = catch(
      "Expected type `%s`, recieved `%s`",
      table.concat(types_checked, "` or `"), typeof(value)
    )
  }
end

--
--- ???
--
--- @
--
local validate_schema = function(target, param)
  local schema = param.type
  target = target or param.default

  if type(target) ~= "table" then
    return { error = catch("Expected type `table`, recieved `%s`", type(target)) }
  end

  -- throw exception if unkown properties are provided

  for key, _ in pairs(target) do
    if not schema[key] then
      return { error = catch("The property '%s' does not exist in the schema", key) }
    end
  end

  -- validate the content of the target table

  for key, property in pairs(schema) do
    local result = _G.validate(target[key], property)

    if result.exception then
      throw("Failed to validate property '%s': %s", key, result.exception)
    end

    target[key] = result.value
  end

  return { value = target }
end

--
--- ???
--
--- @return {value?: any, exception: string|nil}
--
_G.validate = function(value, param)
  local validation = type(param.type)

  return switch(
    validation,
    {
      string = function()
        return validate_simple(value, param)
      end,
      table = function()
        return (#param.type > 0 and validate_multiple(value, param))
            or validate_schema(value, param)
      end
    }
  )
end
