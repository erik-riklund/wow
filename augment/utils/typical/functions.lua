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

--#region [declare: globals]

local exception, type = _G.exception, _G.type

--#endregion
--#region [function: examine]

--
--- Determines the type of a given value, recognizing custom types
--- for objects and distinguishing between lists (numerically indexed tables),
--- maps (tables with non-numeric keys), and empty tables.
--
--- @param value any
--- @return string
--
local function examine(value)
  local value_type = type(value)

  if value_type == 'table' then
    if value.is then
      return value:is() --[[object with a custom type]]
    end

    return #value > 0 and 'list' or next(value) ~= nil and 'map' or 'table'
  end

  return value_type == 'nil' and 'undefined' or value_type
end

--#endregion
--#region [function: validate_schema]

--
--- ???
--
--- @param target table
--- @param schema schema
--- @param parent? string
--
--- @return validation_result
--
local function validate_schema(target, schema, parent) end

--#endregion
--#region [function: validate]

--
--- ???
--
--- @param value any
--- @param options validation_options
--
--- @return validation_result
--
local function validate(value, options) end

--#endregion
--#region [function: required]

--
--- ???
--
--- @param expected_type string|schema
--- @return validation_options
--
local function required(expected_type)
  return { type = expected_type, optional = false }
end

--#endregion
--#region [function: optional]

--
--- ???
--
--- @param expected_type string|schema
--- @param default_value? any
--
--- @return validation_options
--
local function optional(expected_type, default_value)
  return { type = expected_type, optional = true, default = default_value }
end

--#endregion
--#region [function: declare]

--
--- ???
--
--- @param ... parameter
--- @return any ...
--
local function declare(...) end

--#endregion
--#region [declare: api]

_G.typical = {
  declare = declare,
  examine = examine,
  optional = optional,
  required = required,
  validate = validate
}

--#endregion
