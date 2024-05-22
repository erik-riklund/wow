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
--

local params, required, optional, property = import({
  "type.params", "type.params.required", "type.params.optional", "type.schema.property"
})

export(
  "ui.generic.frame",

  function(...)
    local args = params({ ... }, {
      required("name", "string"),
      optional("options", { hidden = property("boolean", false) }, {})
    })

    local frame = CreateFrame("Frame", args.name)
    frame:SetShown(args.options["hidden"] == false)
    
    return frame
  end)
