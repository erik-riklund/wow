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
local type, simple = import({"type.inspect", "type.validate.simple"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ validate.multiple ]
--
-- ???
--
export(
  "type.validate.multiple",
  function(value, param)
    local types = param.type
    local types_n = #types

    local types_checked = {}

    for i = 1, types_n do
      local result =
        simple(
        value,
        {
          type = types[i],
          default = param.default,
          optional = param.optional
        }
      )

      if not result.error then
        return {value = result.value}
      end

      table.insert(types_checked, types[i])
    end

    return {
      error = catch("Expected type `%s`, recieved `%s`", table.concat(types_checked, "` or `"), type(value))
    }
  end
)
