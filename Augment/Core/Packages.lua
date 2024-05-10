local ADDON, CORE = ...
local error, type = error, type

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
local Packages = CORE.Packages
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ @registry ]
--
-- Private field used to store references to registered objects.
--
Packages.registry = {}

--
--[ Packages:Add ]
--
-- Register the provided `object` in the specified `package`.
--
function Packages:Add(package, object)
  if type(package) ~= "string" then
    error("Expected type `string` for parameter 'package'")
  end

  if type(object) ~= "table" or not object.GetName then
    error("Expected type derived from `Object` for parameter 'object'")
  end

  local object_path = ("%s.%s"):format(package, object:GetName())

  if self.registry[object_path] ~= nil then
    error(("The specified package already exists (%s)"):format(object_path))
  end

  self.registry[object_path] = object
  return self.registry[object_path]
end

--
--[ Packages:Use ]
--
-- Return references to the listed `objects` from the specified package.
--
function Packages:Use(package, objects)
  if type(package) ~= "string" then
    error("Expected type `string` for parameter 'package'")
  end

  if type(objects) ~= "table" or #objects == 0 then
    error("Expected type `array` for parameter 'objects'")
  end

  local packages = {}
  for _, object_name in ipairs(objects) do
    local object_path = ("%s.%s"):format(package, object_name)

    if self.registry[object_path] == nil then
      error(("The requested package does not exist (%s)"):format(object_path))
    end

    table_insert(packages, self.registry[object_path])
  end

  return unpack(packages)
end
