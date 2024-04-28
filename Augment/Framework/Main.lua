local ADDON, CORE = ...
local T = Type

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

Debug:Inspect(
  T:Check(
    "test_schema",
    {
      alpha = 1
    },
    T:Schema(
      {

        alpha = T:Any(),
        beta = T:Optional(T:Number()),
        -- charlie = T:Array(),
        -- delta = T:FirstOf(
        --   {
        --     T:String(),
        --     T:Table()
        --   }
        -- )
      }
    )
  )
)
