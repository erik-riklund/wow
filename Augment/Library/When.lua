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
-- Provides a conditional selection mechanism, similar to a compact if-else statement or a ternary operator.
--
-- Parameters:
--   condition (boolean): The boolean expression that determines which value to return.
--   on_true : The value or result of a function to be returned if the condition is true.
--   on_false : The value or result of a function to be returned if the condition is false.

-- Returns:
--   The value associated with `on_true` if the condition is true.
--   The value associated with `on_false` if the condition is false.
--

When = function(condition, on_true, on_false)
  return condition and (type(on_true) == "function" and on_true() or on_true) or
    (type(on_false) == "function" and on_false() or on_false)
end
