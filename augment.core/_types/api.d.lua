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
--- The API for the AUGMENT framework.
--
--- @class API
--
--- @field channel API.channel
--- @field package API.package
--- @field plugin API.plugin
--

--#endregion

--#region [type: API.channel]

--
--- ???
--
--- @class API.channel
--
--- @field transmit fun(channel: string, ...)
--- @field recieve fun(channel: string, callback: function)
--

--#endregion

--#region [type: API.package]

--
--- ???
--
--- @class API.package
--
--- @field import fun(...: string): ...
--- @field export fun(package: string, content: object)
--

--#endregion

--#region [type: API.plugin]

--
--- ???
--
--- @class API.plugin
--
--- @field create fun(id: string): plugin
--

--#endregion

--#region [type: API.utility]

-- todo: continue here!

--#endregion
