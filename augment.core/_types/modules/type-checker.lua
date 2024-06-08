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

--#region [type: schema]

--
--- Represents a blueprint for validating complex data structures (e.g., tables, objects),
--- defining the expected types and validation rules for each property or nested structure.
--
--- @class type.schema : {[string]: type.validation.options}
--

--#endregion

--#region [type: parameter]

--
--- Represents a value passed to a function or property, along with the
--- associated rules for validating its type and other criteria.
--
--- @class type.parameter : {[1]: any, [2]: type.validation.options}
--

--#endregion

--#region [type: validation.options]

--
--- Encapsulates rules used to validate a parameter, including its expected data type,
--- whether it's optional, and a potential default value.
--
--- @class type.validation.options
--
--- @field expect string|type.schema
--- @field optional boolean
--- @field default? any
--

--#endregion

--#region [type: validation.result]

--
--- Encapsulates the outcome of a validation process, indicating whether an error occurred
--- and providing the resulting value (which may be modified from the original).
--
--- @class type.validation.result
--
--- @field error? string
--- @field path? string
--- @field value any
--

--#endregion
