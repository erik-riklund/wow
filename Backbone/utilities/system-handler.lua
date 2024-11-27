
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

--- A utility module for retrieving system-level information.
System = {}

---@return number expansion_id The expansion level (e.g., 0 for Classic, 1 for The Burning Crusade, etc.).
--- Retrieves the current expansion level of the game.
System.getExpansion = function () return GetExpansionLevel() end

---@return string locale The locale string (e.g., "enUS", "deDE").
---Retrieves the client's locale.
---* The locale determines the language and region of the game client.
System.getLocale = function () return GetLocale() end
