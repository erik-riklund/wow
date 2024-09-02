--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Core
local designation, core = ...

--#region (locally scoped functions)

local setmetatable      = _G.setmetatable
local throw             = _G.throw

--#endregion

--#region [class: framework object handler]

--
-- This be the heart of our contraption, the framework context. It's a central workshop
-- where all the gizmos (objects) created by different parts of the framework can be stored
-- and shared, makin' sure everyone's on the same page.
--

--- @type Core
local objectStore       =
{
  --
  -- This be our trusty toolbox, holdin' all the shiny objects we've crafted.
  -- It's like a big ol' warehouse, organized by their unique IDs.
  --

  objects = {},

  --
  -- Adds a new gizmo to our toolbox, but only if it's got a unique ID.
  -- We gotta keep things tidy, no duplicates allowed!
  --

  export = function(self, identifier, object)
    if self.objects[identifier] then
      throw("Export error: An object with the ID '%s' already exists.", identifier)
    end

    self.objects[identifier] = object
  end,

  --
  -- Fetches a gizmo from the toolbox using its ID. If we can't find it,
  -- somethin's gone wrong, so we raise a fuss.
  --

  import = function(self, identifier)
    return self.objects[identifier] or throw(
      "Import error: No object found with the ID '%s'", identifier
    )
  end
}

--#endregion

--
-- This bit of magic connects our framework context (core) to the object handler,
-- givin' it the ability to use the fancy export and import functions we just built.
--
-- It's like installin' a control panel on our main machine!
--

setmetatable(core, { __index = objectStore })
