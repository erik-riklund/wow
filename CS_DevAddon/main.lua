--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

-- This is an example addon which utilize every aspect of the Cogspinner framework.
-- It's used for testing during development and to provide a demonstration of how you
-- can use the various modules for your own projects.

-- ?
local addon_name = ...

-- ?
local plugin = cogspinner.plugin(addon_name, {
  -- ?
  storage = { account = true, character = true }
})

--#region: event handling

-- ?
plugin:listen(
  {
    event = 'BAG_OPEN',

    callback = function()
      print('This callback will run on every trigger of the event.')
    end
  }
)

-- ?
plugin:listen(
  {
    event = 'BAG_OPEN',
    trigger = 'once',

    callback = function()
      print(
        'This callback will run only on the first trigger of the event,'
        .. ' as the `trigger` option is set to \'once\'.'
      )
    end
  }
)

-- ?
plugin:listen(
  {
    event = 'BAG_OPEN',
    callback_id = 'BAG_OPEN_TEST',

    callback = function()
      print(
        'This callback has an assigned ID and will run on the first'
        .. ' trigger of the event, and is then manually removed.'
      )

      plugin:silence('BAG_OPEN', 'BAG_OPEN_TEST')
    end
  }
)

--#endregion

--#region: addon loaded

-- ?
plugin:onload(
  function()
    print(
      'The development plugin has now been fully loaded, and'
      .. ' the storage unit (saved variables) is now usable.'
    )
  end
)

-- ?
plugin:onload(
  function()
    print('Eh?')
  end
)

--#endregion
