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

local switch, type, simple, multiple, schema =
  _G.switch,
  import(
    {
      "type.inspect",
      "type.validate.simple",
      "type.validate.multiple",
      "type.validate.schema"
    }
  )

export(
  "type.validate",
  function(value, param)
    local validation = type(param.type)

    return switch(
      validation,
      {
        string = function()
          return simple(value, param)
        end,
        table = function()
          return (#param.type > 0 and multiple(value, param)) or schema(value, param)
        end
      }
    )
  end
)
