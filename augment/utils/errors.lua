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
--- Raises an error, optionally formatting the provided error message with additional details.
--
--- @param message string
--- @param ... string|number
--
_G.exception = function(message, ...)
  error(... and message:format(...) or message)
end

--
--- Prints a warning message to the console, optionally formatting it with additional details.
--
--- @param message string
--- @param ... string|number
--
_G.warning = function(message, ...)
  print(... and message:format(...) or message)
end
