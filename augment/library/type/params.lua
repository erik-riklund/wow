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

local throw, typeof, validate =
    _G.throw, _G.typeof, _G.validate

--
--- ???
--
--- @
--
_G.params = function(args, params)
  local args_t = typeof(args)
  if args_t ~= "table" then
    throw("Expected type `table` for 'args', recieved `%s`", args_t)
  end

  local params_t = typeof(params)
  if params_t ~= "table" then
    throw("Expected type `table` for 'params', recieved `%s`", params_t)
  end

  -- throw exception on argument count mismatch

  local args_n = #args
  local params_n = #params

  if args_n > params_n then
    if params_n == 0 then
      throw("Expected no arguments")
    end

    throw("Expected %d (or fewer) arguments", params_n)
  end

  -- validate the actual argument values

  local validated_args = {}
  for i = 1, params_n do
    local result = validate(args[i], params[i])

    if result.exception then
      throw("Failed to validate argument #%d (%s): %s", i, params[i].name, result.exception)
    end

    validated_args[params[i].name] = result.value
  end

  return validated_args
end
