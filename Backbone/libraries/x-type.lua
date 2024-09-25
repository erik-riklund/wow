--[[~ Library: Type Extension (xtype) ~

  Version: 1.0.0 | Updated: 2024/09/25

  This library extends Lua's native type system by providing additional functionality 
  for examining and validating types. It introduces new type categories such as 
  'array' and 'empty-table' to handle specific cases more accurately.

  Developer's notes:

  - The `examine` function adds more granular type checking for tables, distinguishing 
    between regular tables, arrays, and empty tables.

  - The `compare` function allows type comparison and supports multiple expected 
    types, including extended types like 'array' and 'empty-table.'

  - Type validation is handled by the `validate` function, ensuring that arguments 
    passed into a function match their expected types. This function is bypassed 
    in production mode to avoid performance overhead.

  Dependencies: xstring (for suffix checking)

]]

---
--- The `xtype` table serves as the namespace for all extended type-related functions 
--- provided by this library.
---
_G.xtype = {}

---
--- Examines the provided value and returns a more detailed type classification.
--- It distinguishes between normal tables, arrays, and empty tables, providing 
--- finer control over type handling.
---
---@param value unknown "The value to be examined for its type."
---@return xtype.type "The extended type classification of the value."
---
xtype.examine = function(value)
  local valueType = type(value)

  -- Check if the value is a table to determine whether it's empty, an array, or a generic table. 
  -- This allows for more specific handling of table types, particularly distinguishing arrays.

  if valueType == 'table' then
    -- Return 'empty-table' if the table is completely empty, which allows it to be treated 
    -- as a separate case from arrays and generic tables.
    
    if next(value) == nil then return 'empty-table' end

    local elementCount = #value
    local actualElementCount = 0

    -- Count the number of elements in the table to differentiate between arrays 
    -- (sequential tables) and generic tables with non-sequential keys.

    for _ in pairs(value) do
      actualElementCount = actualElementCount + 1
    end

    return (elementCount == actualElementCount and 'array') or 'table'
  end

  -- If the value isn't a table, return its standard Lua type unless it's nil, in which case 
  -- 'undefined' is returned for clarity when handling missing or undefined values.

  return (valueType == 'nil' and 'undefined') or valueType --[[@as xtype.type]]
end

---
--- Compares a value against one or more expected types. If the value matches
--- any of the provided types, the function returns `true`; otherwise, it returns `false`.
--- Special handling is provided for empty tables, arrays, and undefined values.
---
---@param value unknown "The value to be compared against the expected types."
---@param types xtype.type | xtype.type[] "The expected type(s) to compare the value against."
---@return boolean, xtype.type "Whether the value matches the expected types and its actual type."
---
xtype.compare = function(value, types)
  local extendedType = xtype.examine(value)
  if _G.production == true then return true, extendedType end

  -- Ensure the types are passed as a table to handle multiple expected types in the comparison.

  if type(types) ~= 'table' then types = { types } end
  for index, expectedType in ipairs(types) do
    if expectedType == extendedType then return true, extendedType end

    -- Handle empty tables separately, as they can be interpreted as arrays or associative tables,
    -- depending on the expected type. This adds flexibility to the comparison process.

    if extendedType == 'empty-table' then
      if expectedType == 'array' or expectedType == 'table' then
        return true, expectedType
      end
    end
  end

  return false, extendedType
end

---
--- Validates a set of arguments against their expected types. Each argument is
--- specified in the form of a table, where the first element defines the expected
--- type(s) and the second element is the actual value to validate.
---
---@param arguments xtype.validation[] "An array of arguments to be validated, with expected types and actual values."
---
xtype.validate = function(arguments)
  if _G.production ~= true then
    for index, argument in ipairs(arguments) do

      -- Split the options string to separate the identifier (the argument name) 
      -- from the expected types. This allows the function to interpret both the 
      -- argument's name and its declared types, ensuring that the value provided 
      -- is of the correct type. If the types are marked as optional (with a '?'), 
      -- the code handles that case separately by modifying the types string for 
      -- validation purposes.

      local options, value = unpack(argument)
      local identifier, types = string.split(':', options)
      if types == nil then error('Missing type declaration for argument.', 3) end

      local optional = xstring.hasSuffix(types, '?')
      if optional == true then types = types:sub(1, #types - 1) end

      ---@type xtype.type[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType = xtype.compare(value, expectedTypes)

      -- Throw an error if the argument type does not match the expected types.
      -- This ensures that developers receive clear, actionable error messages
      -- when their input doesn't conform to expectations.

      if not typesMatch and not (extendedType == 'undefined' and optional) then
        local message = 'Invalid argument type for "%s": expected %s, got %s.'
        local expected = table.concat(expectedTypes, ' or ')

        error(message:format(identifier, expected, extendedType), 3)
      end
    end
  end
end
