
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

--- A utility module for working with time-related functions in the game.
_G.B_Time = {}

---@return number seconds The current time in seconds.
---Retrieves the current in-game time in seconds since the client started.
B_Time.now = function () return GetTime() end

---?
B_Time.precise = function () return GetTimePreciseSec() end
