--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework      = ...

local exception             = _G.exception
local type                  = _G.type

local createListenerManager = framework.import('shared/listeners') --[[@as ListenerManagerConstructor]]
local createRecord          = framework.import('collection/record') --[[@as RecordConstructor]]
local mergeTables           = framework.import('table/merge') --[[@as TableMerger]]

--
-- ?
--

local channels              = createRecord()

--
-- ?
--
--- @param options Channel
--
local createChannel         = function(options)
  return mergeTables(createListenerManager(), options)
end

--
-- ?
--

--- @type Network
local controller            =
{
  --
  -- ?
  --

  reserveChannel = function(options)
    --~ ?

    if channels:entryExists(options.name) then
      exception('?')
    end

    --~ ?

    channels:set(options.name, createChannel(options))
  end,

  --
  -- ?
  --

  registerListener = function(listener) end,

  --
  -- ?
  --

  removeListener = function(identifier, owner) end,

  --
  -- ?
  --

  transmit = function(content) end
}

--
-- ?
--

controller.reserveChannel(
  {
    async = false,
    internal = true,

    name = 'PLUGIN_ADDED'
  }
)

--
-- ?
--
framework.export('module/network', controller)
