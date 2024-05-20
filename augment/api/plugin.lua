local addon, framework = ...

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

local params, required, optional =
  import(
  {
    "type.params",
    "type.params.required",
    "type.params.optional"
  }
)

plugin = function(...)
  local args =
    params(
    {...},
    {
      required("id", "string"),
      required("context", "table"),
      optional("callback", "function")
    }
  )

  -- plugin context initialization ...
end
