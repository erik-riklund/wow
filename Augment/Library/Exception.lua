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
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

Exception = function(exception_type, message)
  error(("<Augment> %s: %s"):format(exception_type or "Exception", message))
end

InvalidTypeException = function(property, expected_type, actual_type)
  Exception(
    "InvalidTypeException",
    ("Expected type `%s` for '%s', recieved `%s`"):format(expected_type, property, actual_type)
  )
end
