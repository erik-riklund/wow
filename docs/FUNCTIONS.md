[Return to the documentation](../README.md)

# Backbone
Version `1.0.0` (*work in progress*)

---

- [Logic-related functions](#logic-related-functions)

  - [backbone.switch](#backboneswitch)
  - [backbone.when](#backbonewhen)

- [String-related functions](#string-related-functions)

  - [backbone.splitString](#backbonesplitstring)

- [Table-related functions](#table-related-functions)

  - [backbone.copyTable](#backbonecopytable)
  - [backbone.createImmutableProxy](#backbonecreateimmutableproxy)
  - [backbone.flattenTable](#backboneflattentable)
  - backbone.integrateTable
  - backbone.integrateTables
  - backbone.traverseTable

## Logic-related functions

This section covers utility functions designed to simplify common logic-based operations. These functions provide concise and readable ways to handle conditions and value selection, reducing the need for verbose conditional statements in your code.

---
### backbone.switch

The `switch` function allows you to evaluate a value against a set of predefined cases and return the corresponding result. It serves as a compact alternative to verbose `if-else` statements, making code more readable and maintainable.

#### Signature

`backbone.switch (value: unknown, cases: table, ...unknown) -> unknown?`

#### Parameters

- `value`

  The value to evaluate. It is compared against the keys in the cases table to determine which case to execute.

- `cases`

  An associative table where:
  - Keys represent potential values of `value`.
  - Values specify the corresponding results or actions for those keys.
  - `default?`
  
    A fallback value or function executed if value does not match any key in the cases table.

- `...unknown`

  Optional arguments passed to the result if it is a function. This allows dynamic case handling when the case result requires additional input.

#### Description

The `switch` function streamlines conditional logic by mapping values to corresponding outcomes in a single, clear structure. Unlike traditional `if-else` statements, it centralizes case handling, improving readability and maintainability.

If `value` matches a key in the `cases` table, the associated value or function is returned. If no match is found and a default case is specified, the default is executed. If neither match nor default exists, the function returns `nil`.

```lua
local result = backbone.switch (
  'apple', {
    apple = 'A fruit',
    carrot = 'A vegetable',
    default = 'Unknown item'
  }
)

print (result) -- Outputs: "A fruit"

local dynamicResult = backbone.switch(
  'add', {
    add = function(a, b) return a + b end,
    subtract = function(a, b) return a - b end,
    default = function() return "Unsupported operation" end
  },
  5, 3 -- Arguments passed to the function.
)

print (dynamicResult) -- Outputs: 8
```

---
### backbone.when

The `when` function provides a concise way to return one of two values based on a boolean condition. It is particularly useful for inline conditional expressions where Lua's built-in short-circuit operators are insufficient or produce unintended behavior.

>

#### Signature

`backbone.when (condition: boolean, onTrue: T, onFalse: T) -> T`

#### Parameters

- `condition`

  A boolean value that determines which argument is returned.

- `onTrue`

  The value returned if `condition` is `true`.

- `onFalse`

  The value returned if `condition` is `false`.

#### Description

This function acts as a hybrid ternary operator, providing an explicit mechanism for conditionally returning one of two values. It is particularly valuable in situations where Lua's short-circuit operators (`and` / `or`) do not suffice or lead to ambiguous behavior. Consider the following example:

```lua
local value = (someValue == nil and variableWithValueFalse) or variableWithValueTrue
```

In this case, the expression would always return `variableWithValueTrue`, even when `someValue` is `nil`, because Lua short-circuits the expression when it encounters a falsy value, leading to potentially unintended results.

Using the `when` function resolves this issue by explicitly evaluating the condition and returning the appropriate value.

```lua
local value = backbone.when (someValue == nil, variableWithValueFalse, variableWithValueTrue)
```

## String-related functions

?

---
### backbone.splitString

The `splitString` function splits a string into substrings based on a specified separator and returns the resulting components as a `Vector`. It also trims whitespace from each component for a clean output. This function provides an efficient way to handle string parsing for dynamic or user-generated input.

#### Signature

`backbone.splitString(target: string, separator: string, pieces?: number) -> Vector`

#### Parameters

- `target`

  The input string to be split into components.

- `separator`

  The delimiter used to identify boundaries between substrings.

- `pieces?`

  The maximum number of substrings to extract. If not provided, the string is split at all occurrences of the separator.

#### Returns

- `Vector` object containing the resulting substrings, with leading and trailing whitespace removed from each.

#### Description

The function divides the `target` string into substrings based on the `separator`. The resulting substrings are stored in a `Vector` for enhanced manipulation and iteration capabilities. During the process, each substring is trimmed of extra whitespace to ensure clean, ready-to-use components.

```lua
local input = '  apple, banana,    cherry,date'
local result = backbone.splitString (input, ',', 3)

-- Result: Vector {'apple', 'banana', 'cherry,date'}
```

## Table-related functions

?

---
### backbone.copyTable

The `copyTable` function creates and returns a shallow copy of the provided table. This is useful when you need to duplicate a table without affecting the original, particularly for tables with simple structures.

#### Signature

`backbone.copyTable (source: table) -> table`

#### Parameters

- `source`

  The table to be copied.

#### Returns

- `table` containing the same elements as the `source` table.

#### Description

The function extracts all elements from the `source` table and creates a new table with the same structure. This approach results in a shallow copy, meaning nested tables or objects within the `source` table are not duplicated but referenced in the new table.

```lua
local original = { 1, 2, 3 }
local copy = backbone.copyTable (original)

table.insert(copy, 4) -- Modifying the copy does not affect the original.

print(original) -- Output: { 1, 2, 3 }
print(copy)     -- Output: { 1, 2, 3, 4 }
```

---
### backbone.createImmutableProxy

The `createImmutableProxy` function creates a read-only proxy for the provided table. It ensures that the original table and its nested tables cannot be modified directly, safeguarding the data against unintended changes. This is useful for creating data structures that are not intended to be modified directly.

#### Signature

`backbone.createImmutableProxy (target: table) -> table`

#### Parameters

- `target`

  The table for which the read-only proxy is created.

#### Returns

- `table` reflecting the structure and content of the `target` table, with read-only access.

#### Description

The function creates a read-only proxy referencing the `target` table through a custom metatable. The proxy intercepts attempts to access or modify elements in the original table:

- Retrieves values from the original table. If the value is itself a table, the proxy recursively creates a read-only proxy for it.
- The proxy is in fact an empty table, but any attempt to modify it results in an error.

```lua
local mutableTable = {
  key1 = 'value1',
  key2 = {
    nestedKey = 'nestedValue'
  }
}

local immutableProxy = backbone.createImmutableProxy (mutableTable)

print (immutableProxy.key1)           -- Output: "value1"
print (immutableProxy.key2.nestedKey) -- Output: "nestedValue"

immutableProxy.key1 = 'newValue'           -- Error: Cannot modify a read-only table
immutableProxy.key2.nestedKey = 'newValue' -- Error: Cannot modify a read-only table
```

---
### backbone.flattenTable

The `flattenTable` function transforms a nested table into a single-level table, representing the original structure through a nested key scheme. This is particularly useful for serializing, debugging, or handling deeply nested data in a simpler format.

#### Signature

`backbone.flattenTable (target: table, parents?: string, result?: table) -> table`

#### Parameters

- `target`

  The input table to be flattened. It should contain nested tables or key-value pairs to process.

- `parents?`

  A string representing the parent key path for nested elements. This is used internally to track the hierarchy during recursion. If omitted, the function starts from the root level.

- `result?`

  A table to collect the flattened key-value pairs. If not provided, a new table is created.

#### Returns

- `table` containing the flattened version of the input table, where keys represent the original nested structure using a slash (`/`) delimiter.

#### Description

The function iterates through each key-value pair in the `target` table. For nested tables, it recursively processes their contents, appending the current key to the parent path to form a hierarchical key. Non-table values are added directly to the `result` table with their corresponding flattened keys. Keys starting with a `$` character are excluded from recursion but added as-is to the flattened table.

```lua
local nestedTable = {
  a = 1,
  b = {
    c = 2,
    d = {
      e = 3
    }
  },
  ['$hidden'] = { f = 4 }
}

local flattened = backbone.flattenTable (nestedTable)

-- Result:
-- {
--   ["a"] = 1,
--   ["b/c"] = 2,
--   ["b/d/e"] = 3,
--   ["$hidden"] = { f = 4 } -- Preserved as a non-recursed key.
-- }
```