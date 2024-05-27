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
--- Determines the type of a given value, recognizing custom types
--- for objects and distinguishing between lists (numerically indexed tables),
--- maps (tables with non-numeric keys), and empty tables.
--
--- @param value any
--- @return string
--
function _G.examine(value)
  local value_type = type(value)

  if value_type == 'table' then
    if value.is then
      return value:is() -- object with a custom type
    end

    return #value > 0 and 'list' or next(value) ~= nil and 'map' or 'table'
  end

  return value_type == 'nil' and 'undefined' or value_type
end
