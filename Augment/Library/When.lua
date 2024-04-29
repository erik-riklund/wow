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
--- Provides conditional value selection, acting like a flexible ternary operator.
--
-- This function evaluates the `condition` and returns either the result of calling 
-- `on_true` (if it's a function) or the value of `on_true` directly if the
-- condition is true. Otherwise, it does the same for `on_false`.
--
-- @param condition boolean The condition to evaluate.
-- @param on_true any The value or function to return if the condition is true.
-- @param on_false any The value or function to return if the condition is false.
-- @return any The result of evaluating `on_true` or `on_false` based on the condition. 
--

When = function(condition, on_true, on_false)
  return condition and (type(on_true) == "function" and on_true() or on_true) or
    (type(on_false) == "function" and on_false() or on_false)
end
