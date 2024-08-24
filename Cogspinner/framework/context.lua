--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

local setmetatable, throw = setmetatable, throw

--#region [controller: framework context]

--
-- This controller provides the basic import/export functionality for the
-- framework context, allowing different parts of the framework to share
-- objects in a controlled manner.
--

--- @type core.context
local context_controller =
{
  --
  -- A central data store to hold exported objects, accessible via
  -- unique identifiers (IDs). This allows modules to share objects
  -- without relying on global variables.
  --

  data = {},

  --
  -- Exports an object to the context's data store, making it available for
  -- import by other modules. We throw an error if the ID is already in use
  -- to prevent accidental overwrites.
  --

  export = function(self, id, object)
    if self.data[id] then
      throw("Export error: An object with the ID '%s' already exists in the context.", id)
    end

    self.data[id] = object
  end,

  --
  -- Imports an object from the context's data store using its unique
  -- identifier. If the object is not found, an error is thrown to signal
  -- a potential dependency issue.
  --

  import = function(self, id)
    return self.data[id] or throw("Import error: No object found with the ID '%s'", id)
  end
}

--#endregion

--
-- Links the `context_controller` to the framework's context object as its
-- metatable, making the import/export functionalities available throughout
-- the framework via the `context` object.
--

setmetatable(context, { __index = context_controller })
