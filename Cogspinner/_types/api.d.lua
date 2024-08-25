--- @meta

--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--#region [type: framework API]

--
--- ?
---
--- @class API
--- 
--- @field utility utility.API
--- 
--- @field plugin fun(id: string, options: plugin.options): plugin.API
--

--#endregion

--#region [type: utility API]

--
--- ?
---
--- @class utility.API
--- 
--- @field collection utility.collection.API
--- @field table utility.table.API
--- @field throw utility.throw
--

--#endregion

--#region [type: utility/collection API]

--
--- ?
---
--- @class utility.collection.API
--- 
--- @field map utility.collection.map
--- @field list utility.collection.list
--

--#endregion

--#region [type: utility/table API]

--
--- ?
---
--- @class utility.table.API
--- 
--- @field immutable utility.table.immutable
--

--#endregion