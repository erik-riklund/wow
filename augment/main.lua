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
--

--#region [ "global" variables ]

--
--- ???
--
local modules =
{
  --
  --- ???
  --
  tasks = {}
}

--#region: type-checking functions
local declare = _G.typical.declare
local required = _G.typical.required
local optional = _G.typical.optional
--#endregion

--#endregion

--#region [ module: tasks ]

--
--- ???
--
--- @type list<task>
--
modules.tasks._queue = {}

--
--- ???
--
--- @type thread
--
modules.tasks._handler = nil

--#region ( function: tasks.queue )

--
--- ???
--
--- @param callback function
--
function modules.tasks:register(callback, ...) end

--
--- ???
--
--- @private
--
function modules.tasks:_execute() end

--#endregion


--#endregion
