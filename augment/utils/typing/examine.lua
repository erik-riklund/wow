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
--- Examine the given `value` to determine its data type, returned as a string representation.
-- * Possible return values are `undefined`, `boolean`, `string`, `number`, `function`, `userdata`, or `thread`.
-- * Extended types for tables include `array` for numerically indexed tables, `hashmap` for associative tables, or `table` for empty tables.
-- * In addition, it supports the return of custom types for objects that implement the `getType` method.
--
--- @param value any
--- @return string
--
_G.examine = function(value)
  local actual_type = type(value)

  if actual_type == "table" then
    if value.getType then return value:getType() end
    return #value > 0 and "array" or next(value) ~= nil and "hashmap" or "table"
  end

  return actual_type == "nil" and "undefined" or actual_type
end
