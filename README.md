# Backbone
Version `1.0.0` (*work in progress*)
### A World of Warcraft addon development framework

Backbone is a World of Warcraft addon development framework that provides a solid foundation for building robust, efficient, and maintainable addons. With a powerful toolkit at its core, the framework is designed to be easy to use, maintainable, and foster a thriving community around it. Its lightweight footprint and modular design make it an ideal choice for developers of all skill levels.

## Table of contents

1. [Introduction](#1-introduction)
    - [Features](#features)
2. [Usage examples](#2-usage-examples)
3. [Framework reference](#3-framework-reference)
    - [Static resources](#static-resources)
4. [Plugin reference](#4-plugin-reference)
5. [Framework library](#5-framework-library)
    - [Classes](#classes)
    - [Functions](#functions)
    - [Enumerations](#enumerations)

## 1. Introduction

Backbone is built to streamline the process of addon development by offering
- ?

?

### Features

- ?

The framework not only emphasizes performance but also fosters a cooperative ecosystem where addons can communicate and integrate efficiently. Developers can leverage shared data through services and channels, enabling richer experiences for players while maintaining compatibility.

## 2. Usage examples

The examples in this section use the `plugin` variable to represent an instance of the `Plugin` class, which is an active plugin created by calling the [`backbone.createPlugin`](#3-framework-reference) method. The `plugin` variable is used to illustrate the usage of various plugin methods and demonstrate how they can be leveraged to create a robust and well-structured addon.

```lua
--The name of the plugin must match the name of the addon folder.
local plugin = backbone.createPlugin 'MyPlugin'
```

## 3. Framework reference

The following methods are part of the global `backbone` table and can be accessed directly from within your addon. These methods provide a way to interact with the framework and its underlying components.

---
`backbone.createPlugin (name: string) -> Plugin`
- `name` A string specifying the name of the plugin to be created.

Creates and returns a new plugin with the specified name. A plugin encapsulates a suite of services and communication channels that facilitate interaction with the framework and other plugins. If a plugin with the specified name already exists, an error is raised.

> For details on available plugin methods, see the [Plugin reference](#4-plugin-reference).

---
`backbone.executeTask (task: table)`
- `task` A table containing the following properties:

  - `id` A unique identifier for the task. This is optional, but useful for debugging.
  - `callback` A function that will be called when the task is executed. This function should not return a value but can leverage closures or externally defined variables. Any errors raised by this function will be printed to the chat frame.
  - `arguments` A `Vector` containing the arguments that will be passed to the `callback` function when the task is executed. This is optional, and can be omitted if no arguments are needed.

This function executes a given task synchronously on the main thread. During its execution, the main thread is paused until the task completes, potentially impacting the responsiveness of the game.

---
`backbone.executeBackgroundTask (task: table)`
- `task` A table containing the following properties:

  - `id` A unique identifier for the task. This is optional, but useful for debugging.
  - `callback` A function that will be called when the task is executed. This function should not return a value but can leverage closures or externally defined variables. Any errors raised by this function will be printed to the chat frame.
  - `arguments` A `Vector` containing the arguments that will be passed to the `callback` function when the task is executed. This is optional, and can be omitted if no arguments are needed.

This function executes a given task asynchronously using a coroutine. During its execution, the main thread should not be affected, which can be useful for long-running tasks that do not need to be executed immediately. Background tasks are executed in the order they were added.

---
`backbone.hasPlugin (name: string) -> boolean`
- `name` A string specifying the name of the plugin to be checked.

Determines whether a plugin with the specified name has been registered with the framework. Returns `true` if the plugin exists, `false` otherwise.

---
`backbone.throw (error: string, ...string)`
- `error` A string specifying the error message to be thrown.
- `...` Optional arguments to be used for formatting the error message.

Throws an error with the given message, optionally formatting it with the provided arguments. This function is intended to be used to throw errors when invalid operations are attempted. The error is thrown with a stack trace at level 3, pointing to the location where the error originated from.

---
### Static resources

The following section lists static resources that are exposed by the framework. These resources are available globally and can be accessed by any plugin or addon.

`backbone.activeLocale`

The currently active locale, represented as a string (e.g., `enUS`, `frFR`, `deDE`).

`backbone.currentExpansion`

The currently active expansion level, represented as an `ENUM.EXPANSION_LEVEL` value.

## 4. Plugin reference

?

## 5. Framework library

?

### Classes

Each class provided by the framework includes a globally accessible constructor function. The constructor functions are named after the class they instantiate, and can be called directly to initialize new objects with any necessary initial parameters. If a constructor function is not explicitly documented below, no initial parameters are required; these objects can be initialized using the shorthand `new 'ClassName'` syntax for convenience.

---
#### Dictionary

A dictionary is a data structure that stores key-value pairs. It is a mutable collection of entries, each consisting of a unique key and an associated value. The dictionary provides methods for adding, removing, and iterating over entries, as well as checking for the existence of a key. The dictionary is a key component of the framework's data model, and is used extensively in plugin development.

`Dictionary (initialContent?: table<string|table, unknown>) -> Dictionary`
- `initialContent` An optional table containing the initial key-value pairs for the dictionary.
  - If omitted, the dictionary starts empty.

Creates a new `Dictionary` instance with the optional initial content.

---
`Dictionary:getEntry (key: string|table) -> unknown`
- `key` The key for which the associated value should be retrieved.

Retrieves the value associated with the given key. If the key does not exist in the dictionary, `nil` is returned.

---
`Dictionary:setEntry (key: string|table, value: unknown)`
- `key` The key for which the associated value should be set.
- `value` The value to be associated with the given key.

Sets a key-value pair in the dictionary. If the key already exists, its associated value is updated.

---
`Dictionary:hasEntry (key: string|table) -> boolean`
- `key` The key for which the existence of an associated value should be checked.

Determines whether a key exists in the dictionary. Returns `true` if the key exists, `false` otherwise.

---
`Dictionary:dropEntry (key: string|table)`
- `key` The key for which the associated value should be removed.

Removes an entry from the dictionary by key. If the key does not exist in the dictionary, this method does nothing.

---
`Dictionary:forEach (callback: (key: string|table, value: unknown) -> unknown?)`
- `callback` A function that will be called for each key-value pair in the dictionary.
  - The function should accept two arguments: `key` and `value`. If the function returns a value, it will be used to update the dictionary; if it returns `nil`, the entry remains unchanged.

---
`Dictionary:getIterator () -> function, table<string|table, unknown>`

Returns an iterator function that can be used with a `for` loop to traverse the dictionary's key-value pairs. The iterator returns the key and value for each iteration.

---
#### Listenable

A listenable is an object that can be registered for events of various types. Listeners can be registered to be notified when an event of interest occurs. Listeners can be either persistent or non-persistent; persistent listeners remain active until explicitly removed, while non-persistent listeners are removed once they have been invoked.

`Listenable:getListenerCount () -> number`

Returns the total number of registered listeners.

---
`Listenable:registerListener (listener: Listener)`
- `listener` A table containing the following properties:

  - `id` A unique identifier for the listener. This is optional, but useful for debugging and required for targeted removal.
  - `callback` A function that will be called when the event is invoked. This function should not return a value but can leverage closures or externally defined variables. Any errors raised by this function will be printed to the chat frame.
  - `persistent` A boolean indicating whether the listener is persistent or non-persistent. This property is optional, and defaults to `true`.
    - If `false`, the listener is removed after being invoked.

Registers a new listener whose callback function will be invoked when the `Listenable` object is triggered. If the listener is persistent, it will remain active until explicitly removed; if it is non-persistent, it will be removed after being invoked.

---
`Listenable:removeListener (id: string)`
- `id` The identifier of the listener to be removed.

Removes a listener by its identifier.

---
`Listenable:invokeListeners (arguments?: Vector, executeAsync?: boolean)`
- `arguments` A `Vector` containing the arguments that will be passed to the listeners' callback functions. 
  - This is optional, and can be omitted if no arguments are needed.
- `executeAsync` A boolean indicating whether the listeners' callback functions should be executed asynchronously.
  - If omitted, defaults to `true`.

Invokes all registered listeners, passing the provided arguments to their callback functions. Non-persistent listeners are automatically removed after execution. The invocation is asynchronous by default, but can be made synchronous by setting `executeAsync` to `false`.

---
### Functions

This section details the various utility functions provided by the framework. These functions are designed to facilitate addon development by offering a variety of common operations. Each function is exposed to the global namespace and can be directly invoked from within your plugin or addon.

---
`flattenTable (target: table) -> table`
- `target` The table that should be flattened.

Flattens a table recursively into a single table, using a nested key scheme to represent the original table's structure. Returns a new table with the flattened structure.

> If a key starts with `$`, it acts as a breaking point. The value of that key, and any nested tables, will be stored in their original forms.

---
`integrateTable (base: table, source: table, mode: string) -> table`
- `base` The base table into which the source table should be integrated.
- `source` The source table to be integrated into the base table.
- `mode` The integration mode, which can be `skip`, `replace` or `strict`.
  - If omitted, the default mode is `strict`.

Integrates the source table into the base table, using the specified mode to handle key collisions. Returns the modified base table.

>The `mode` parameter controls how the source table is integrated:
>
>  - `skip` Existing keys in the base table will not be overwritten.
>  - `replace` Existing keys in the base table are overwritten with values from the source table.
>  - `strict` Key collisions result in an error being raised.

---
`split (target: string, separator: string, pieces?: number) -> Vector`
- `target` The string to be split.
- `separator` The string to use as the separator.
- `pieces` The number of pieces to split the string into (optional).
  - If omitted, an unbounded number of pieces is returned.

Splits a string into a set of substrings based on the specified separator. Returns the resulting substrings as a `Vector` object.

---
`traverseTable (target: table, steps: table, mode?: string) -> unknown`
- `target` The table to be traversed.
- `steps` A table containing the sequence of keys to traverse.
- `mode` The traversal mode, which can be `exit`, `build` or `strict`.

This function allows for the recursive traversal of a table by following a sequence of keys provided in the `steps` table. It returns the value found at the end of this traversal. The behavior of the traversal is determined by the optional `mode` parameter. Throws an error if a non-table value is encountered prior to the last step.

> The `mode` parameter controls the behavior of the traversal:
> - `exit` The traversal will stop when the specified key is not found, returning `nil`.
> - `build` The traversal will create any missing tables in the path, returning the final value.
> - `strict` The traversal will raise an error if any key in the path is not found.

---
### Enumerations

The `ANCHOR_POINT` enumeration provides numerical representations of anchor points used for positioning UI elements.

```lua
ENUM.ANCHOR_POINT = {
      TOPLEFT = 1,
     TOPRIGHT = 2,
   BOTTOMLEFT = 3,
  BOTTOMRIGHT = 4,
          TOP = 5,
       BOTTOM = 6,
         LEFT = 7,
        RIGHT = 8,
       CENTER = 9
}
```

The `EXPANSION_LEVEL` enumeration provides numerical representations of expansion levels.

```lua
ENUM.EXPANSION_LEVEL = {
          CLASSIC = 0,
  BURNING_CRUSADE = 1,
        LICH_KING = 2,
        CATACLYSM = 3,
         PANDARIA = 4,
          DRAENOR = 5,
           LEGION = 6,
          AZEROTH = 7,
      SHADOWLANDS = 8,
     DRAGONFLIGHT = 9,
       WAR_WITHIN = 10
}
```

The `ITEM_BIND` enumeration provides numerical representations of item bindings.

```lua
ENUM.ITEM_BIND = {
        NONE = Enum.ItemBind.None,
  ON_ACQUIRE = Enum.ItemBind.OnAcquire,
    ON_EQUIP = Enum.ItemBind.OnEquip,
      ON_USE = Enum.ItemBind.OnUse,
       QUEST = Enum.ItemBind.Quest,
     ACCOUNT = Enum.ItemBind.ToWoWAccount,
     WARBAND = Enum.ItemBind.ToBnetAccount,
  WARBAND_EQ = Enum.ItemBind.ToBnetAccountUntilEquipped
}
```

The `ITEM_CLASS` enumeration provides numerical representations of item types.

```lua
ENUM.ITEM_CLASS = {
  CONSUMABLE = Enum.ItemClass.Consumable,
  CONTAINER  = Enum.ItemClass.Container,
      WEAPON = Enum.ItemClass.Weapon,
       ARMOR = Enum.ItemClass.Armor,
     REAGENT = Enum.ItemClass.Reagent,
  PROJECTILE = Enum.ItemClass.Projectile,
  TRADEGOODS = Enum.ItemClass.Tradegoods,
      RECIPE = Enum.ItemClass.Recipe,
      QUIVER = Enum.ItemClass.Quiver,
       QUEST = Enum.ItemClass.Questitem,
         KEY = Enum.ItemClass.Key,
        MISC = Enum.ItemClass.Miscellaneous,
   BATTLEPET = Enum.ItemClass.Battlepet,
   WOW_TOKEN = Enum.ItemClass.WoWToken
}
```

The `ITEM_QUALITY` enumeration provides numerical representations of item qualities.

```lua
ENUM.ITEM_QUALITY = {
       POOR = Enum.ItemQuality.Poor,
     COMMON = Enum.ItemQuality.Common,
   UNCOMMON = Enum.ItemQuality.Uncommon,
       RARE = Enum.ItemQuality.Rare,
       EPIC = Enum.ItemQuality.Epic,
  LEGENDARY = Enum.ItemQuality.Legendary,
   ARTIFACT = Enum.ItemQuality.Artifact,
   HEIRLOOM = Enum.ItemQuality.Heirloom,
  WOW_TOKEN = Enum.ItemQuality.WoWToken
}
```

The `LOOT_SLOT_TYPE` enumeration provides numerical representations of loot slot types.

```lua
ENUM.LOOT_SLOT_TYPE = {
      NONE = Enum.LootSlotType.None,
      ITEM = Enum.LootSlotType.Item,
     MONEY = Enum.LootSlotType.Money,
  CURRENCY = Enum.LootSlotType.Currency
}
```

The `TRADESKILL_SUBTYPE` enumeration provides numerical representations of tradeskill item subtypes.

```lua
ENUM.TRADESKILL_SUBTYPE = {
               PARTS = 1,
       JEWELCRAFTING = 4,
               CLOTH = 5,
             LEATHER = 6,
              METALS = 7,
             COOKING = 8,
                HERB = 9,
           ELEMENTAL = 10,
               OTHER = 11,
          ENCHANTING = 12,
         INSCRIPTION = 16,
   OPTIONAL_REAGENTS = 18,
  FINISHING_REAGENTS = 19
}
```
