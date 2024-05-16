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
--[ export ]
--
-- ???
--
export = function(package, content)
  if type(package) ~= "string" then
    throw("Expected type `string` for 'package'")
  end

  if _packages[package] ~= nil then
    throw("Unable to register package '%s' as it already exists", package)
  end

  _packages[package] = content
end

--
--[ Load ]
--
-- ???
--
local load = function(package)
  if type(package) ~= "string" then
    throw("Expected type `string` for 'package'")
  end

  if _packages[package] == nil then
    throw("The requested package '%s' does not exist", package)
  end

  return _packages[package]
end

--
--[ import ]
--
-- ???
--
import = function(packages)
  if type(packages) ~= "table" then
    throw("Expected an array of package names for 'packages'")
  end

  local imported_packages = {}
  for i = 1, #packages do
    table.insert(imported_packages, Load(packages[i]))
  end

  return unpack(imported_packages)
end
