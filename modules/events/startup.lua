---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/05 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

---Channel used to broadcast the loading of a plugin.
---
context.plugin:createChannel('PLUGIN_LOADED',
  { internal = true, executeAsync = false }
)

---Channel used to broadcast that a plugin has been initialized.
---
context.plugin:createChannel('ADDON_READY', { executeAsync = false })

---Handles the ADDON_LOADED event.
---
context.frame:HookScript(
  'OnEvent', function (frame, eventName, ...)
    ---@cast eventName string
    if eventName == 'ADDON_LOADED' then
      local addon = select(1, ...) --[[@as string]]

      if backbone.hasPlugin (addon) then
        context.plugin:invokeChannel (
          'PLUGIN_LOADED', context.getPlugin (addon)
        )
      end

      context.plugin:invokeChannel ('ADDON_READY', addon)
    end
  end
)

-- FRAMEWORK API --

---@param name string
---@param callback function
---Execute the provided callback once the addon is fully loaded.
---* May be called multiple times; the callbacks are executed in the order they were added.
---
backbone.onAddonLoaded = function (name, callback)
  local isLoaded = select(2, C_AddOns.IsAddOnLoaded (name))
  if isLoaded then return callback() end -- exit early if the addon is already loaded.

  context.plugin:registerChannelListener('ADDON_READY', {
    callback = function(addon)
      -- TODO: add identifier.
    end, 
    identifier = string.format('ADDON_READY/%s/%s', name, GetTimePreciseSec()),
    persistent = false,
  })
end

-- PLUGIN API --

---@class Plugin
local eventsAPI = context.pluginApi

---@param callback function
---Execute the provided callback once the plugin is fully initialized.
---* May be called multiple times; the callbacks are executed in the order they were added.
---
eventsAPI.onReady = function (self, callback)
  backbone.onAddonLoaded (self.name, callback)
end
