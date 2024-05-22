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
-- A private table that stores registered packages and their associated content.
--
local _packages = {}

--
--[ export ]
--
-- Registers a new package with the specified name and content.
-- Throws an error if the package name is invalid or already exists.
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
-- Retrieves the content of a registered package by its name. Throws an error
-- if the package name is invalid or the package does not exist.
--
local load = function(package)
  if type(package) ~= "string" then
    throw("Expected type `string` for 'package'.")
  end

  if _packages[package] == nil then
    throw("The requested package '%s' does not exist", package)
  end

  return _packages[package]
end

--
--[ import ]
--
-- Loads and returns the content of multiple packages specified in an array.
-- Throws an error if the input is not a table of package names.
--
import = function(packages)
  if type(packages) ~= "table" then
    throw("Expected an array of package names for 'packages'")
  end

  local imported_packages = {}
  for i = 1, #packages do
    table.insert(imported_packages, load(packages[i]))
  end

  ---@diagnostic disable-next-line: deprecated
  return unpack(imported_packages)
end
