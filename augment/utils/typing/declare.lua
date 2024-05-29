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
--- @param args list<any>
--- @param params list<parameter>
--
--- @return any ...
--
function _G.declare(args, params)
  if #args > #params then -- we use return here to cancel the rest of the execution when running tests
    return exception(
      "Too many arguments provided, please check your function call " ..
      "and ensure the correct number of arguments are used")
  end

  -- todo > implement the function ...

  return unpack(args)
end
