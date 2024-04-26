local ADDON, CORE = ...
local Type = Type
local Error = Type.Errors

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

--
-- Creates a type validator that specifically checks if a value is nil
-- (effectively checking if it's undefined).
--
-- Returns:
--   A new type validation function
--

function Type:Undefined()
  return self:Validator("nil")
end

--
-- Creates a type validator function specifically designed to check if a value is of the
-- boolean type (true or false). It also offers the flexibility of using a default value.
--
-- Parameters:
--   default_value : An optional default boolean value to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function
--

function Type:Boolean(default_value)
  return self:Validator("boolean", default_value)
end

--
-- Creates a type validator function that checks if a value is a string. It also provides the
-- option to set a default string value.
--
-- Parameters:
--   default_value (optional): A default string value to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:String(default_value)
  return self:Validator("string", default_value)
end

--
-- Creates a type validator function that specifically verifies if a value is a number.
-- It also allows you to set a default numerical value.
--
-- Parameters:
--   default_value (optional): A default number to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Number(default_value)
  return self:Validator("number", default_value)
end

--
-- Creates a type validation function specifically for checking if a value is an array (which is
-- represented as a table with sequential numeric indices). It also allows for a default array value.
--
-- Parameters:
--   default_value (optional): A default array (table) to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Array(default_value)
  return self:Validator("array", default_value)
end

--
-- Creates a type validation function designed to verify if a value is a Lua table.
-- It also provides the option to set a default table value.
--
-- Parameters:
--   default_value (optional): A default table to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Table(default_value)
  return self:Validator("table", default_value)
end

--
-- Creates a type validator function that specifically checks if a value is a
-- callable function. It also allows for providing a default function.
--
-- Parameters:
--   default_value (optional): A default function to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Function(default_value)
  return self:Validator("function", default_value)
end

--
-- Creates a type validation function specifically designed to check if a value is of the
-- "userdata" type. It allows you to optionally provide a default userdata object.
--
-- Parameters:
--   default_value (optional): A default userdata object to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Userdata(default_value)
  return self:Validator("userdata", default_value)
end

--
-- Creates a type validation function designed to verify if a value represents a thread (coroutine).
-- It also allows for providing a default thread.
--
-- Parameters:
--   default_value (optional): A default coroutine (thread) to use if the value being validated is nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Thread(default_value)
  return self:Validator("thread", default_value)
end

--
-- Creates a type validator that accepts values of any type, except for nil.
--
-- Returns:
--   A new type validation function.
--

function Type:Any()
  return self:Not(self:Undefined())
end

--
-- Creates a validator that allows a value to either match a specific type or be nil
-- (effectively making it optional).
--
-- Parameters:
--   validator (function): A type validator function (likely created using one of your other Type functions like Type:String or Type:Number).

-- Returns:
--   A new type validation function.
--

function Type:Optional(validator)
  return self:First({validator, self:Undefined()})
end

--

--

function Type:First(validators)
  for _, validator in ipairs(validators) do
    
    -- TODO > implement this!
    
  end
end

--
-- Creates a new type validator that inverts the result of an existing validator.
-- Essentially, it checks if a value is not of a specific type.
--
-- Parameters:
--   validator (function): An existing type validation function.
--
-- Returns:
--   A new type validation function.
--

function Type:Not(validator)
  --
  return function(validation_type, key, value, quiet)
    --
    local validation = validator(validation_type, key, value, true)
    local passed = validation.result.actual_type == validation.result.expected_type

    if not passed and not quiet then
      self:Error(
        Error.INVALID_TYPE,
        ("not %s"):format(validation.result.expected_type),
        validation_type,
        key,
        validation.result.actual_type
      )
    end

    return {passed = passed, result = validation.result}
  end
end
