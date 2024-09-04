--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework = ...

local coroutine        = _G.coroutine

local setTimer         = C_Timer.After
local createList       = framework.import('collection/list') --[[@as ListConstructor]]

--
-- ?
--
local tasks            = createList()

--
-- ?
--
--- @type thread
--
local controller

controller             = coroutine.create(
  function()
    local frameLimit = 0.0167 -- 60fps
    local GetTime = _G.GetTime

    while true do
      local initiated = GetTime()

      if tasks:size() > 0 then
        while tasks:size() > 0 and (GetTime() - initiated < frameLimit) do
          -- todo: implement task execution
        end
      end

      if tasks:size() > 0 then
        setTimer(frameLimit, function() coroutine.resume(controller) end)
      end

      coroutine.yield()
    end
  end
)

--
-- ?
--
--- @type TaskHandler
--
local registerTask     = function(callback, ...)
  if type(callback) ~= 'table' then
    exception('?')
  end

  -- todo: implement task registration

  if coroutine.status(controller) == 'suspended' then
    coroutine.resume(controller)
  end
end

--
-- ?
--
framework.export('module/task', registerTask)
