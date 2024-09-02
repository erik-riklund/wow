--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, table
local designation, core = ...

--#region (locally scoped functions)

local setmetatable      = _G.setmetatable
local throw             = _G.throw
local type              = _G.type

--#endregion

--#region [class: framework object handler]

--
-- This be the heart of our contraption, the framework context. It's a central workshop
-- where all the gizmos (objects) created by different parts of the framework can be stored
-- and shared, makin' sure everyone's on the same page.
--

local objectStore       =
{
  __index =
  {
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

  } --[[@as Context]]
}

--
-- This clever function be the key to openin' up a whole new workshop!
-- It takes any ol' table and turns it into a proper framework context,
-- ready to store and share all sorts of useful gadgets.
--

--- @type ContextConstructor
local function createContext(target)
  if type(target) ~= 'table' then
    throw('Invalid target. Expected a table, but got a %s.', type(target)) 
  end

  target.objects = {}
  setmetatable(target, objectStore)
end

--#endregion

--
-- This bit of magic connects our framework context (core) to the object handler,
-- givin' it the ability to use the fancy export and import functions we just built.
--
-- It's like installin' a control panel on our main machine!
--

createContext(core)

--
-- And finally, we share the function with the rest of the workshop, so any module
-- can set up their own little context for organizin' their inventions!
--

--- @cast core Context
core:export('module/context', createContext)
