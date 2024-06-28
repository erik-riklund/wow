--- @meta

--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--#region [type: API]

--
--- @class API
--
--- @field channel API.channel
--- @field package API.package
--- @field plugin API.plugin
--- @field utility API.utility
--

--#endregion

--#region [type: API.channel]

--
--- @class API.channel
--
--- @field transmit fun(channel: string, ...)
--- @field recieve fun(channel: string, callback: function)
--

--#endregion

--#region [type: API.package]

--
--- @class API.package
--
--- @field import fun(...: string): ...
--- @field export fun(package: string, content: object)
--

--#endregion

--#region [type: API.plugin]

--
--- @class API.plugin
--
--- @field create fun(id: string): plugin
--

--#endregion

--#region [type: API.utility]

--
--- @class API.utility
--
--- @field string API.utility.string
--- @field table API.utility.table
--
--- @field exception fun(message: string, ...: string | number)
--

--
--- @class API.utility.string
--
--- @field split fun(target: string, separator: string): list<string>
--

--
--- @class API.utility.table
--
--- @field readonly fun(target: table): table
--- @field walk fun(target: table, path: string, build_mode?: boolean): table | nil
--

--#endregion
