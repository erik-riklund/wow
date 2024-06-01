---@meta
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
--- @class schema : {[string]: validation_options}
--

--#endregion [type: schema]

--#region [type: parameter]

--
--- Represents a value passed to a function or property, along with the
--- associated rules for validating its type and other criteria.
--
--- @class parameter : {[1]: any, [2]: validation_options}
--

--#endregion [type: parameter]

--#region [type: validation_options]

--
--- Encapsulates rules used to validate a parameter, including its expected data type,
--- whether it's optional, and a potential default value.
--
--- @class validation_options
--
--- @field expect string|schema
--- @field optional boolean
--- @field default? any
--

--#endregion [type: validation_options]

--#region [type: validation_result]

--
--- Encapsulates the outcome of a validation process, indicating whether an error occurred
--- and providing the resulting value (which may be modified from the original).
--
--- @class validation_result
--
--- @field error? string
--- @field path? string
--- @field value any
--

--#endregion [type: validation_result]

--#region [type: list<v>]

--
--- Represents an ordered collection of elements of a specific type `v`,
--- where each element is accessed by a numerical index.
--
--- @class list<v> : {[integer]: v}
--

--#endregion [type: list<v>]

--#region [type: map<k,v>]

--
--- Represents an unordered collection of key-value pairs, where each unique
--- key of type `k` is associated with a corresponding value of type `v`.
--
--- @class map<k,v> : { [k]:v }
--

--#endregion [type: map<k,v>]
