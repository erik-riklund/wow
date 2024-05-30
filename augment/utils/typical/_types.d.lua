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

--#region [type: schema]

--
--- Represents a blueprint for validating complex data structures (e.g., tables, objects),
--- defining the expected types and validation rules for each property or nested structure.
--
--- @class schema : {[string]: validation_options|schema}
--

--#endregion
--#region [type: parameter]

--
--- Represents a value passed to a function or property, along with the
--- associated rules for validating its type and other criteria.
--
--- @class parameter : {[1]: any, [2]: validation_options}
--

--#endregion
--#region [type: validation_options]

--
--- Encapsulates rules used to validate a parameter, including its expected data type,
--- whether it's optional, and a potential default value.
--
--- @class validation_options
--
--- @field type string|schema
--- @field optional boolean
--- @field default? any
--

--#endregion
--#region [type: validation_result]

--
--- Encapsulates the outcome of a validation process, indicating whether an error occurred
--- and providing the resulting value (which may be modified from the original).
--
--- @class validation_result
--
--- @field error? string
--- @field value any
--

--#endregion
