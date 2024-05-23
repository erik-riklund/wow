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
--- This function acts as a translator, interpreting the underlying data type of a given
--- value and expressing it in a standardized vocabulary suitable for validation purposes.
--
--- @return string
--
_G.typeof = function(value)
  local actual_type = type(value)

  return switch(
    actual_type,
    {
      default = actual_type,
      ["nil"] = "undefined",

      table = function()
        return #value > 0 and "array" or next(value) and "hashmap" or "table"
      end
    }
  )
end
