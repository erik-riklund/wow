---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'backbone-plugin' --[[@as plugin]]

--[[~ Script: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  ?

  Features:

  - ?

  Dependencies: ?

]]

-- [explain this section up until the next placeholder]

plugin:registerCommand('FRAMEWORK_MODE_TOGGLE', 'backbone', function(message, source)
  message = string.lower(message)

  if message == 'development' or message == 'production' then
    _G.production = (message == 'production')
    console.info('Production mode is now $state.', {
      state = (_G.production and processMarkup '<color=olivine>enabled</color>')
        or processMarkup '<color=watermelon>disabled</color>',
    })
  else
    console.info 'Expected syntax: /backbone development\124production'
  end
end)
