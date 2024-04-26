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

function Type:GetType(input)
  local input_type = type(input)

  if input_type ~= "table" then
    return input_type
  end

  local numeric_indexes = false
  local is_empty = next(input) == nil

  -- TODO > check for numeric indexes

  return (is_empty or numeric_indexes and "array") or "table"
end

function Type:Param(name, value, callback)
  if self.Enabled then
    local validation = callback("parameter", name, value)

  -- ???
  end

  return value -- type-checking is disabled
end

function Type:Schema(target, schema)
  if self.Enabled then
    local target = target or {}
    local target_type = type(target)

    if target_type ~= "table" then
      self:Error(Error.INVALID_TYPE, "table", "parameter", "target", target_type)
    end

  -- ???
  end

  return target -- type-checking is disabled
end

function Type:Validator(expected_type, default_value)
  return function(validation_type, key, value, quiet)
    local quiet = quiet or false
    local passed = false

    local result = {
      value = value or default_value,
      actual_type = self:GetType(value or default_value),
      expected_type = expected_type
    }

    if result.actual_type == "array" and result.expected_type == "table" then
      -- Treat empty arrays and tables as interchangeable due to their indistinguishability.
      passed = #result.value == 0
    end

    if not passed and not quiet and result.actual_type ~= result.expected_type then
      self:Error(Error.INVALID_TYPE, result.expected_type, validation_type, key, result.actual_type)
    end

    return {passed = passed, result = result}
  end
end
