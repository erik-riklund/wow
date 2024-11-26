
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

--- A utility module for checking the status of in-game units.
_G.B_Unit = {}

---@param unit UnitToken The unit token (e.g., "player", "target") to check.
---@return boolean is_afk `true` if the unit is AFK, `false` otherwise.
---Checks if the specified unit is marked as AFK (away from keyboard).
B_Unit.isAFK = function (unit) return UnitIsAFK (unit) end

---@param unit UnitToken The unit token (e.g., "player", "target") to check.
---@return boolean on_taxi `true` if the unit is on a flight path, `false` otherwise.
---Checks if the specified unit is currently on a flight path.
B_Unit.onTaxi = function (unit) return UnitOnTaxi (unit) end
