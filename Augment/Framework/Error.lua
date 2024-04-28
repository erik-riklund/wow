local ADDON, CORE = ...
local Markup = Markup

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

--- Throws an error with a potentially formatted message.
-- @param message string The error message template.
-- @param variables table (optional) A table of variables to substitute into the message.
-- @throws error Always throws an error with the provided message. 

function Throw(message, variables)
  --
  if variables then
    message = Markup:Parse(message, variables)
  end

  error(message)
end

--- Processes and returns an error message template.
-- @param message string The message template.
-- @param variables table (optional) A table of variables to substitute into the message.
-- @return string The processed message. 

function Catch(message, variables)
  return Markup:Parse(message, variables)
end