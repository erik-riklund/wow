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
--[ PackageHandler ]
--
-- A module for managing and loading class packages.
--
local PackageHandler = {
  --
  --[ _packages ]
  --
  -- A private table storing the registered packages and their content.
  --
  _packages = {},
  --
  --[ Add ]
  --
  -- Registers a new package with the given name and content.
  --
  Add = function(self, package, content)
    if type(package) ~= "string" then
      Exception:Throw("Expected type `string` for 'package'")
    end

    if self._packages[package] ~= nil then
      Exception:Throw("Unable to register package '%s' as it already exists", package)
    end

    self._packages[package] = content
  end,
  --
  --[ Load ]
  --
  -- Retrieves the content of a registered package by its name.
  --
  Load = function(self, package)
    if type(package) ~= "string" then
      Exception:Throw("Expected type `string` for 'package'")
    end

    if self._packages[package] == nil then
      Exception:Throw("The requested package '%s' does not exist", package)
    end

    return self._packages[package]
  end,
  --
  --[ Use ]
  --
  -- Loads and returns the content of multiple packages specified in an array.
  --
  Import = function(self, packages)
    if type(packages) ~= "table" then
      Exception:Throw("Expected an array of package names for 'packages'")
    end

    local imported_packages = {}
    for i = 1, #packages do
      table.insert(imported_packages, self:Load(packages[i]))
    end

    return unpack(imported_packages)
  end
}

--
--[ Import ]
--
-- Global API function used to import packages.
--
Import = function(packages)
  return PackageHandler:Import(packages)
end

--
--[ Export ]
--
-- Global API function used to register a new package.
--
Export = function(package, content)
  PackageHandler:Add(package, content)
end
