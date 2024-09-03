--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, table
local addonId, context  = ...

local exception         = _G.exception
local setmetatable      = _G.setmetatable
local type              = _G.type

--
-- This metatable provides the implementation for a 'Context' object, enabling object sharing
-- between modules, thus promoting modularity and helping avoid global variable pollution.
--

local contextController =
{
  __index =
  {
    --
    -- Registers an object for import by other modules, ensuring unique
    -- identifiers for conflict prevention and data integrity.
    --

    export = function(self, identifier, object)
      if self.objects[identifier] ~= nil then
        exception('Export failed: An object with the identifier "%s" already exists.', identifier)
      end

      self.objects[identifier] = object
    end,

    --
    -- Retrieves an exported object from the context using its identifier,
    -- providing a controlled way to access shared objects.
    --

    import = function(self, identifier)
      if self.objects[identifier] == nil then
        exception('Import failed: The requested object (%s) does not exist.', identifier)
      end

      return self.objects[identifier]
    end

  } --[[@as Context]]
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--- @type ContextConstructor
local createContext     = function(target)
  if type(target) ~= 'table' then
    exception('Invalid argument type. Expected a table, received "%s".', type(target))
  end

  if target.objects ~= nil then
    exception('Context initialization failed: The target table already has an "objects" field.')
  end

  target.objects = {}
  return setmetatable(target, contextController)
end

--
-- Initializes the shared `context` table as a Context object,
-- enabling it to store and share objects throughout the framework.
--

createContext(context)

--- @cast context Context
context:export('module/context', createContext)
