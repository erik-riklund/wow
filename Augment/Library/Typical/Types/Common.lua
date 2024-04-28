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

local Type = Type
local Error = Type.Errors

--
--- Creates a validator function specifically for checking if a value is undefined (nil).
-- @return function A validator function that returns true if the passed value is `nil`.
--

function Type:Undefined()
  return self:Validator("undefined")
end

--
--- Creates a validator function specifically for checking boolean types.
--
-- @param default_value boolean (optional) A default boolean value to use if the original value is nil.
-- @return function A validator function that checks if a value is a boolean or converts it to
--                  a boolean using the provided default value.
--

function Type:Boolean(default_value)
  return self:Validator("boolean", default_value)
end

--
--- Creates a validator function specifically for checking string types.
--
-- @param default_value string (optional) A default string value to use if the original value is nil.
-- @return function A validator function that checks if a value is a string or converts it to
--                  a string using the provided default value.
--

function Type:String(default_value)
  return self:Validator("string", default_value)
end

--
--- Creates a validator function specifically for checking number types.
--
-- @param default_value number (optional) A default number value to use if the original value is nil.
-- @return function A validator function that checks if a value is a number or converts it to
--                  a number using the provided default value.
--

function Type:Number(default_value)
  return self:Validator("number", default_value)
end

--
--- Creates a validator function specifically for checking function types.
--
-- @param default_value function (optional) A default function to use if the original value is nil.
-- @return function A validator function that checks if a value is a function or uses
--                  the provided default function.
--

function Type:Function(default_value)
  return self:Validator("function", default_value)
end
