local examine, exception = _G.examine, _G.exception
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
--- ???
--
--- @param args any[]
--- @param params param[]
--- @return any ...
--
_G.declare = function(args, params)
  --
  -- 1: check argument types

  if examine(args) ~= "array" then
    exception("Expected type `array` for argument #1 (args)")
  end

  if examine(params) ~= "array" then
    exception("Expected type `array` for argument #2: (params)")
  end

  --
  -- 2: ensure correct number of arguments

  if #args > #params then
    exception("Expected a maximum of %d argument(s), recieved %d", #params, #args)
  end

  --
  -- 3: use the specified parameters to validate the provided arguments

  local _args = {}

  for index, param in ipairs(params) do
    local value = args[index] or param.default
    param.optional = param.optional == nil and false or param.optional

    if value ~= nil or param.optional == false then
      local result = compare(value, param.expected_type)

      if result.success == false then
        exception("Type mismatch for argument #%d (%s): %s", index, param.name, result.error)
      end
    end

    _args[index] = value
  end

  --
  -- 4: Return each validated argument separately

  return unpack(_args)
end
