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

_G.typeof = function(value)
  local actual_type = type(value)

  return switch(
    actual_type,
    {
      default = actual_type,
      ["nil"] = "undefined",

      table = function()
        if value.get_type then
          return value:get_type()
        end

        return #value > 0 and "array" or next(value) and "hashmap" or "table"
      end
    }
  )
end
