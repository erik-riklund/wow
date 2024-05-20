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

local pairs, type =
  _G.pairs,
  import(
    {
      "type.inspect"
    }
  )

export(
  "type.validate.schema",
  function(target, param)
    local schema = param.type
    target = target or param.default

    if type(target) ~= "table" then
      return {error = catch("Expected type `table`, recieved `%s`", type(value))}
    end

    -- throw exception if unkown properties are provided

    for key, _ in pairs(target) do
      if not schema[key] then
        return {error = catch("The property '%s' does not exist in the schema", key)}
      end
    end

    -- validate the content of the target table

    local validate = import({"type.validate"})
    for key, property in pairs(schema) do
      local result = validate(target[key], property)

      if result.error then
        throw("Failed to validate property '%s': %s", key, result.error)
      end

      target[key] = result.value
    end

    return {value = target}
  end
)
