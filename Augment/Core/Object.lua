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

--
--[ Object ]
--
-- Pseudo-class wrapper providing shared functionality for objects.
--
local Object = function(class_name, class)
  if type(class_name) ~= "string" then
    error(("Expected type `string` for 'class_name', recieved `%s`"):format(type(class_name)))
  end

  if type(class) ~= "table" then
    error(("Expected type `table` for 'class', recieved `%s`"):format(type(class)))
  end

  class.__index = class
  class._name = class_name

  setmetatable(
    class,
    {
      __index = {
        --
        --[ Create ]
        --
        -- Create a new instance of an object. If a constructor method is available,
        -- it will be invoked before returning the new object instance.
        --
        Create = function(self, ...)
          local object = {}
          setmetatable(object, {__index = self})

          if object.Constructor then
            object:Constructor(...)
          end

          return object
        end,
        --
        --[ GetType ]
        --
        -- Returns the object's type, can be used to enforce strict type checking.
        --
        GetType = function(self)
          return self._type or "object"
        end,
        --
        --[ SetType ]
        --
        -- Set the type of the object itself, used for type checking.
        --
        SetType = function(self, object_type)
          self._type = object_type
        end,
        --
        --[ GetName ]
        --
        -- Returns the name of the class that the object is an instance of.
        --
        GetName = function(self)
          return self._name
        end
      }
    }
  )

  return class
end

--
-- ???
--
Export("Core.Object", Object)
