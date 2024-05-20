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

local params, required, optional, property =
  import(
  {
    "type.params",
    "type.params.required",
    "type.params.optional",
    "type.schema.property"
  }
)

local print = function(output, depth)
  local indent = string.rep("   ", depth or 0)
  _G.print(indent .. output)
end

local inspect = function(...)
  local args =
    params(
    {...},
    {
      required("target", "any"),
      optional("depth", "number", 0)
    }
  )

  local depth = args.depth
  local target_type = type(args.target)

  switch(
    target_type,
    {
      table = function()
        print("(", depth)
        for key, value in pairs(args.target) do
          local value_type = type(value)

          switch(
            value_type,
            {
              default = function()
                print(("[%s: %s] = %s"):format(tostring(key), value_type, tostring(value)), depth + 1)
              end,
              --
              string = function()
                if #value > 49 then
                  value = string.sub(value, 1, 49) .. "..."
                end

                print(("[%s: %s] = \"%s\""):format(tostring(key), value_type, value), depth + 1)
              end,
              --
              table = function()
                local inspect = import({"debug.inspect"})
                print(("[%s: %s] = "):format(tostring(key), value_type), depth + 1)
                inspect(value, depth + 1)
              end
            }
          )
        end
        print(")", depth)
      end
    }
  )
end

export("debug.inspect", inspect)
