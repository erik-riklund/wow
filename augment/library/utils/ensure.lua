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
--- This function acts as a safeguard, verifying that a certain condition holds true.
--- If it doesn't, it triggers a warning to prevent further issues.
--
--- @param condition boolean
--- @param exception string
--
_G.ensure = function(condition, exception, ...)
  assert(condition, ... and exception:format(...) or exception)
end
