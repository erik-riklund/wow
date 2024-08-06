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

--#region: event handling through the plugin API

-- ?
plugin:listen(
  {
    event = 'PLAYER_STARTED_MOVING',

    callback = function()
      print('This callback will run on every trigger of the event.')
    end
  }
)

-- ?
plugin:listen(
  {
    event = 'PLAYER_STARTED_MOVING',
    trigger = 'once',

    callback = function()
      print(
        'As the `trigger` option is set to \'once\', this callback'
        .. ' will run only on the first trigger of the event.'
      )
    end
  }
)

-- ?
plugin:listen(
  {
    event = 'PLAYER_STARTED_MOVING',
    callback_id = 'test',

    callback = function()
      print(
        'We assign an ID to this callback, causing it to run on the first'
        .. ' trigger of the event, and then we manually remove it.'
      )

      plugin:silence('PLAYER_STARTED_MOVING', 'test')
    end
  }
)

--#endregion

--#region: delayed execution until the plugin has finished loading

-- ?
plugin:onload(
  function()
    print(
      'The development plugin has now been fully loaded, and'
      .. ' the storage module (saved variables) is now usable.'
    )
  end
)

-- ?
plugin:onload(
  function()
    print(
      'In the same way as with regular events, multiple callbacks may be'
      .. ' registered to execute when the addon has fully loaded.'
    )
  end
)

--#endregion

--#region: using the network to communicate with other plugins



--#endregion
