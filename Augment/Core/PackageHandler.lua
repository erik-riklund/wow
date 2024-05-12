--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ PackageHandler ]
--
-- ???
--
local PackageHandler = {
  --
  --[ _packages ]
  --
  -- ???
  --
  _packages = {},
  --
  --[ Add ]
  --
  -- ???
  --
  Add = function(self, package, content)
    print("Add - not implemented")
  end,
  --
  --[ Use ]
  --
  -- ???
  --
  Import = function(self, packages)
    print("Use - not implemented")
  end
}

--
--[ Import ]
--
-- ???
--
Import = function(packages)
  return Framework.PackageHandler:Import(packages)
end

--
--[ Export ]
--
-- ???
--
Export = function(package, content)
  Framework.PackageHandler:Add(package, content)
end
