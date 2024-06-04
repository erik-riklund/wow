---@diagnostic disable: need-check-nil

local _, CORE = ...
--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--- @cast CORE framework

local self = CORE.libs.type
local throw = CORE.libs.exception.throw

--#region [method: examine]

--- Determines the type of a given value, recognizing custom types
--- for objects and distinguishing between lists (numerically indexed tables),
--- maps (tables with non-numeric keys), and empty tables.
--
self.examine = function(value)
  local value_type = type(value)

  if value_type == 'table' then
    if type(value.__type) == 'function' then
      return value:__type() -- note: object with a custom type
    end

    return #value > 0 and 'list' or next(value) ~= nil and 'map' or 'table'
  end

  return value_type == 'nil' and 'undefined' or value_type
end

--#endregion

--#region [method: validate]

--
--- Acts as a gatekeeper, ensuring that a given value adheres to a set of predefined
--- validation rules (the options). It first checks for basic type compatibility and,
--- if necessary, delves deeper to examine complex data structures according to a schema.
--
--- If the value passes all checks, it is returned (possibly modified); otherwise,
--- the first encountered violation is reported.
--
self.validate = function(value, options, parent)
  local result = (
    { value = value or options.default } --[[@as type.validation.result]]
  )

  if self.production_mode == true then
    return result -- note: no validation performed in production mode!
  end

  --#region: simple type validation

  if type(options.expect) == 'string' then
    --#region: Explanation of the type validation logic:
    -- 1. Check if there is a value (not nil) OR the parameter is required (not optional).
    --    If so, and the actual type doesn't match the expected type, proceed to the next step.
    -- 2. If the expected type is 'list' or 'map', AND the actual type is 'table', the validation passes.
    -- 3. If the expected type is not 'any', an error is raised due to the type mismatch from the first step.
    --    If the expected type is 'any', and the actual value is 'undefined' (nil), an error is raised.
    --#endregion

    local actual_type = self.examine(result.value)
    local expected_type = options.expect --[[@as string]]

    if (value ~= nil or options.optional ~= true) and actual_type ~= expected_type then
      if not ((expected_type == 'list' or expected_type == 'map') and actual_type == 'table') then
        if expected_type ~= 'any' or expected_type == 'any' and actual_type == 'undefined' then
          result.error = string.format("Expected a value of type `%s` but recieved `%s`", expected_type, actual_type)
        end
      end
    end
  end

  --#endregion

  --#region: schema validation

  if type(options.expect) == 'table' then
    local schema_result = self.validate_schema(
      value, options.expect --[[@as type.schema]], parent
    )

    if schema_result.error then
      result.error = schema_result.error
      result.path = schema_result.path
    end
  end

  --#endregion

  return result
end

--#endregion

--#region [method: validate_schema]

--
--- Recursively validates a complex data structure (table) against a predefined schema,
--- ensuring that each property in the table conforms to its corresponding definition in the schema.
--
--- It performs nested validations for properties with complex types (defined by another schema)
--- and tracks the path to the property where any validation error occurs. If the data structure
--- passes all checks, the potentially modified structure is returned; otherwise, a detailed error
--- message pinpointing the invalid property and its path is returned.
--
self.validate_schema = function(target, schema, parent)
  local result = (
    { value = target } --[[@as type.validation.result]]
  )

  --#region: property validation

  for property, _ in pairs(target) do
    if schema[property] == nil then
      result.error = "Unexpected property: '" .. property .. "' is not defined in the schema"
      return result
    end
  end

  --#endregion

  --#region: schema validation

  for property, options in pairs(schema) do
    local heritage = (parent or '') .. '/' .. property

    --#region: property validation

    local property_validation = self.validate(
      target[property], options, type(options.expect) == 'table' and heritage or nil
    )

    --#endregion

    --#region: validation error

    if property_validation.error then
      result.error = property_validation.error
      result.path = property_validation.path or heritage

      break -- abort the rest of the validation process
    end

    --#endregion

    result.value[property] = property_validation.value
  end

  --#endregion

  --#region: root-level error formatting

  if not parent and result.error then
    result.error = ("Schema validation failed @ \"%s\": %s"):format(result.path, result.error)
  end

  --#endregion

  return result
end

--#endregion

--#region [method: required]

--
--- Generates validation options for a required parameter or property,
--- specifying the expected data type and marking it as not optional.
--
self.required = function(expected_type)
  return { expect = expected_type, optional = false }
end

--#endregion

--#region [method: optional]

--
--- Generates validation options for an optional parameter or property,
--- specifying the expected data type, marking it as optional, and providing
--- a default value to be used if the value is not provided.
--
self.optional = function(expected_type, default_value)
  return { expect = expected_type, optional = true, default = default_value }
end

--#endregion

--#region [method: declare]

--
--- Validates a sequence of values against their corresponding parameter definitions,
--- ensuring they meet the specified type and validation criteria. If all values pass
--- validation, they are unpacked and returned as individual arguments; otherwise,
--- the first validation error is thrown, halting execution.
--
self.declare = function(...)
  local arguments = ({} --[[@as list<any>]])

  for i, parameter in ipairs({ ... }) do
    local value, options = parameter[1], parameter[2]
    local result = self.validate(value, options)

    if result.error then
      --#region: Why use return with throw?
      -- We do this for testing purposes, to allow mocking of the `throw`
      -- method to return the error messages instead of triggering a Lua error.
      --#endregion

      return throw("Type error for argument #%d: %s", i, result.error)
    end

    table.insert(arguments, result.value)
  end

  return unpack(arguments)
end

--#endregion
