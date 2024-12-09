---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/09 | Author(s): Gopher ]]

--Backbone - A World of Warcraft addon framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

local services = new 'Dictionary'

-- FRAMEWORK API --

---@param name string
---@return boolean
---Checks whether the specified service exists.
---
backbone.hasService = function (name)
---@diagnostic disable-next-line: missing-return
end

---@param name string
---@param service Backbone.Service
---Registers a service with the specified name.
---
backbone.registerService = function (name, service)  end

---@param name string
---@return Backbone.Service
---Returns the service with the specified name.
---
backbone.requestService = function (name) 
---@diagnostic disable-next-line: missing-return
end
