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
--- @param args table
--- @param params table
---
--- @params
---
--
_G.declare = function(args, params)
  --
  assert(
    type(args) == "table",
    "Expected an array of arguments"
  )

  assert(
    type(params) == "table",
    "Expected an array of parameter declarations"
  )

  assert(
    #args <= #params,
    "Expected a maximum of " .. #params .. " arguments"
  )

  --
end
