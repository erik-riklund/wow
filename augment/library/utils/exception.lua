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
--- Trigger an exception with a formatted message.
--
--- @param message string
--- @param ... string|number Placeholders used, if provided, to format the `message`.
--
_G.throw = function(message, ...)
  error((... and message:format(...)) or message)
end

--
--- Format and return the specified error message.
--
--- @param message string
--- @param ... string|number Placeholders used, if provided, to format the `message`.
--
_G.catch = function(message, ...)
  return (... and message:format(...)) or message
end
