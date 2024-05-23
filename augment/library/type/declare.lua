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

--
--- This function acts as a gatekeeper for other functions, ensuring that the arguments they
--- receive are valid and conform to expected standards before allowing them to proceed.
--
--- @param args table
--- @param params table
---
--- @params
--- * args: table   - The values passed as arguments to the function.
--- * params: table - The parameter definitions specifying validation rules.
---
--- @return ...
--
_G.declare = function(args, params)
  --
  ensure(type(args) == "table", "Expected an array of arguments")
  ensure(type(params) == "table", "Expected an array of parameter declarations")
  ensure(#args <= #params, "Expected a maximum of %d arguments", #params)

  local exception = "Failed validation of parameter #%d (%s): %s"

  for index, param in ipairs(params) do
    local arg = args[index]

    if arg == nil and not param.optional and param.default == nil then
      throw(exception, index, param.name, "Missing value for non-optional argument")
    end

    if arg ~= nil then
      local result = compare(args[index], param.type, param.default)
      if result.error then throw(exception, index, param.name, result.error) end

      local arg_type = type(args[index])
      if not param.allow_empty and (arg_type == "string" or arg_type == "table") and #args[index] == 0 then
        throw(exception, index, param.name, "Empty argument values are not allowed")
      end

      args[index] = result.value
    end
  end

  return unpack(args)
end
