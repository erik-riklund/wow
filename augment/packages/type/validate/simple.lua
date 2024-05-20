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

local type =
  import(
  {
    "type.inspect"
  }
)

export(
  "type.validate.simple",
  function(value, param)
    value = value or param.default
    local actual_type = type(value)

    if
      (actual_type == "undefined" and not param.optional) or
        (param.type ~= "any" and param.type ~= actual_type and not (actual_type == "undefined" and param.optional))
     then
      return {error = catch("Expected type `%s`, recieved `%s`", param.type, actual_type)}
    end

    return {value = value}
  end
)
