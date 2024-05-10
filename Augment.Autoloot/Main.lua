local ADDON, APP = ...

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

OnLoad(
  ADDON,
  function()
    print("Hello world")

    local tree = Map:New({"string", "array(function)"})
    local list = Array:New(T:Or({"string","number"}))
  end
)

-- function test(one, two, three)
--   local one = T:Check("one", one, "number")
--   local two = T:Check("two", two, {"string", "Default value!"})
--   local three = T:Check("three", three, "map(string, array(function))")
-- end
