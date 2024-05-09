local ADDON, CORE = ...

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
local Object = {} -- define the generic base object
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

local Base = {
  --
  --[ Base:New ]
  --
  -- ???
  --
  New = function(self, ...)
    local object = {}
    setmetatable(object, {__index = self})

    if object.type == "abstract" or object.type == "static" then
      error(("Cannot instantiate abstract/static class (%s)"):format(self:GetName()))
    end

    if object.Init then
      object:Init(...)
    end

    return object
  end,
  --
  --[ Base:Extend ]
  --
  -- ???
  --
  Extend = function(self, name, class_type)
    local subclass = {name = name or "Object", parent = self, type = class_type}
    subclass.__index = subclass
    setmetatable(subclass, {__index = self})

    return subclass
  end
}

Object.__index = Object
setmetatable(Object, {__index = Base})

--
--[ Object:GetName ]
--
-- ???
--
function Object:GetName()
  return self.name
end

--
--[ Object:ToString ]
--
-- ???
--
function Object:ToString()
  return (self.name == "Object" and self.name) or ("Object<%s>"):format(self.name)
end

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--
CORE.Object = Object -- export to the framework namespace
