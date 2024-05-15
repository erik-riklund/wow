local type = type
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

--
--[ packages ]
--
-- ???
--
local _packages = {}

--
--[ Export ]
--
-- ???
--
Export = function(package, content)
  if type(package) ~= "string" then
    Throw("Expected type `string` for 'package'")
  end

  if _packages[package] ~= nil then
    Throw("Unable to register package '%s' as it already exists", package)
  end

  _packages[package] = content
end

--
--[ Load ]
--
-- ???
--
local Load = function(package)
  if type(package) ~= "string" then
    Throw("Expected type `string` for 'package'")
  end

  if _packages[package] == nil then
    Throw("The requested package '%s' does not exist", package)
  end

  return _packages[package]
end

--
--[ Import ]
--
-- ???
--
Import = function(packages)
  if type(packages) ~= "table" then
    Throw("Expected an array of package names for 'packages'")
  end

  local imported_packages = {}
  for i = 1, #packages do
    table.insert(imported_packages, Load(packages[i]))
  end

  return unpack(imported_packages)
end
