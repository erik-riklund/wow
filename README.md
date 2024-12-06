# Backbone
Version `1.0.0` (*work in progress*)
### A World of Warcraft addon development framework

Backbone is a comprehensive World of Warcraft addon development framework that simplifies the process of creating robust, efficient, and maintainable addons. By providing a user-friendly and intuitive toolkit, Backbone allows developers to focus on crafting unique features and functionalities, while automating tedious tasks and reducing boilerplate code. Whether you are a seasoned developer or just starting out, Backbone offers a solid foundation for building high-quality addons.

## Table of contents

1. [Introduction](#1-introduction)
    - [Features](#features)
    - [Developer community](#developer-community)
2. [Usage examples](#2-usage-examples)
3. [Framework reference](#3-framework-reference)
    - [Static resources](#static-resources)
4. [Plugin reference](#4-plugin-reference)
5. [Framework library](#5-framework-library)
    - [Classes](#classes)
    - [Functions](#functions)
    - [Enumerations](#enumerations)

## 1. Introduction

?

The framework not only emphasizes performance but also fosters a cooperative ecosystem where addons can communicate and integrate efficiently. Developers can leverage shared data through services and channels, enabling richer experiences for players while maintaining compatibility.

### Features

- ?

### Developer community

The Backbone community is a collaborative space where developers can share knowledge, solve problems, and create new things together. We believe that by fostering an open and inclusive environment, we can create a more vibrant and diverse ecosystem of World of Warcraft addons. The community is built on a culture of mutual respect, empowerment, and open communication. It is meant to be a place where you can connect with other developers, get help when you need it, or share your latest project. By discussing and collaborating with like-minded individuals, we can achieve amazing things.

> [Join the Backbone community on Discord](https://discord.gg/JaHq2wWweS)

## 2. Usage examples

The examples in this section use the `plugin` variable to represent an instance of the `Plugin` class, which is an active plugin created by calling the [`backbone.createPlugin`](#3-framework-reference) method. The `plugin` variable is used to illustrate the usage of various plugin methods and demonstrate how they can be leveraged to create a robust and well-structured addon.

```lua
--The name of the plugin must match the name of the addon folder.
local plugin = backbone.createPlugin 'MyPlugin'
```

?

## 3. Framework reference

The following methods are part of the global `backbone` table and can be accessed directly from within your addon. These methods provide a way to interact with the framework and its underlying components.

---
- `backbone.createPlugin (name: string) -> Plugin`
  - `name` A string specifying the name of the plugin to be created.

  Creates and returns a new plugin with the specified name. A plugin encapsulates a suite of services and communication channels that facilitate interaction with the framework and other plugins. If a plugin with the specified name already exists, an error is raised.

  > For details on available plugin methods, see the [Plugin reference](#4-plugin-reference).

- `backbone.executeTask (task: table)`
  - `task` A table containing the following properties:

    - `id` A unique identifier for the task.
      - May be omitted, but it is useful for debugging.
    - `callback` A function that will be called when the task is executed. This function should not return a value but can leverage closures or externally defined variables.
      - Any errors raised by this function will be printed to the chat frame.
    - `arguments` A `Vector` containing the arguments that will be passed to the `callback` function when the task is executed. This is optional, and can be omitted if no arguments are needed.

  This function executes a given task synchronously on the main thread. During its execution, the main thread is paused until the task completes, potentially impacting the responsiveness of the game.

- `backbone.executeBackgroundTask (task: table)`
  - `task` A table containing the following properties:

    - `id` A unique identifier for the task.
      - May be omitted, but it is useful for debugging.
    - `callback` A function that will be called when the task is executed. This function should not return a value but can leverage closures or externally defined variables.
      - Any errors raised by this function will be printed to the chat frame.
    - `arguments` A `Vector` containing the arguments that will be passed to the `callback` function when the task is executed. This is optional, and can be omitted if no arguments are needed.

  This function executes a given task asynchronously using a coroutine. During its execution, the main thread should not be affected, which can be useful for long-running tasks that do not need to be executed immediately. Background tasks are executed in the order they were added.

- `backbone.hasPlugin (name: string) -> boolean`
  - `name` A string specifying the name of the plugin to be checked.

  Determines whether a plugin with the specified name has been registered with the framework. Returns `true` if the plugin exists, `false` otherwise.

- `backbone.throw (error: string, ...string)`
  - `error` A string specifying the error message to be thrown.
  - `...` Optional arguments to be used for formatting the error message.

  Throws an error with the given message, optionally formatting it with the provided arguments. This function is intended to be used to throw errors when invalid operations are attempted. The error is thrown with a stack trace at level 3, pointing to the location where the error originated from.

---
### Static resources

The following section lists static resources that are exposed by the framework. These resources are available globally and can be accessed by any plugin or addon.

- `backbone.activeLocale`

  The currently active locale, represented as a string (e.g., `enUS`, `frFR`, `deDE`).

- `backbone.currentExpansion`

  The currently active expansion level, represented as an `ENUM.EXPANSION_LEVEL` value.

## 4. Plugin reference

*Describe the purpose of the `Plugin` class.*

### Channels

?

### Events

?

### Locales

Locales enable support for multiple languages and the customization of text elements based on the user’s active locale. With this feature, you can create a more inclusive and accessible user experience, catering to a diverse audience. The framework provides methods for registering localized strings for specific locales and retrieving them dynamically, ensuring that your plugin’s text aligns seamlessly with the user’s language settings.

- `plugin:registerLocalizedStrings (locale: LocaleCode, strings: table)`
  - `locale` A string specifying the locale for which the strings should be registered.
  - `strings` A table containing the strings to be registered for the specified locale.

  Registers strings for a specific locale. These strings can be used in the plugin's UI or other user-facing elements, allowing for locale-specific customization of the plugin's text.

  > This method can be called multiple times to register strings for different locales or to update existing ones. When a locale is already registered, the new strings are merged with the existing ones. However, any key collisions will result in an error.

- `plugin:getLocalizedString (key: string) -> string`
  - `key` A string specifying the key of the string to be retrieved.

  Retrieves a localized string for the specified key. The string will be returned in the active locale, falling back to the default locale (`enUS`) if no localized string is available for the active locale.

  > If the key is not found in any of the registered locales, an error string is returned.

### Settings

?

## 5. Framework library

The framework library is a collection of classes andfunctions that are made available to all plugins and addons. It provides a variety of utility functions and data structures that can be used to write robust and efficient code. The library is divided into two main sections: classes and functions. It also provides a set of enumerations that can be used to represent different types of data.

### Classes

Each class provided by the framework includes a globally accessible constructor function. The constructor functions are named after the class they instantiate, and can be called directly to initialize new objects with any necessary initial parameters. If a constructor function is not explicitly documented below, no initial parameters are required; these objects can be initialized using the shorthand `new 'ClassName'` syntax for convenience.

#### Dictionary

A dictionary is a data structure that stores key-value pairs. It is a mutable collection of entries, each consisting of a unique key and an associated value. The dictionary provides methods for adding, removing, and iterating over entries, as well as checking for the existence of a key. The dictionary is a key component of the framework's data model, and is used extensively in plugin development.

- `Dictionary (initialContent?: table<string|table, unknown>) -> Dictionary`
  - `initialContent` An optional table containing the initial key-value pairs for the dictionary.
    - If omitted, the dictionary starts empty.

  Creates a new `Dictionary` instance with optional initial content.

- `Dictionary:getEntry (key: string|table) -> unknown`
  - `key` The key for which the associated value should be retrieved.

  Retrieves the value associated with the given key. If the key does not exist in the dictionary, `nil` is returned.

- `Dictionary:setEntry (key: string|table, value: unknown)`
  - `key` The key for which the associated value should be set.
  - `value` The value to be associated with the given key.

  Sets a key-value pair in the dictionary. If the key already exists, its associated value is updated.

- `Dictionary:hasEntry (key: string|table) -> boolean`
  - `key` The key for which the existence of an associated value should be checked.

  Determines whether a key exists in the dictionary. Returns `true` if the key exists, `false` otherwise.

- `Dictionary:dropEntry (key: string|table)`
  - `key` The key for which the associated value should be removed.

  Removes an entry from the dictionary by key. If the key does not exist in the dictionary, this method does nothing.

- `Dictionary:forEach (callback: (key: string|table, value: unknown) -> unknown?)`
  - `callback` A function that will be called for each key-value pair in the dictionary.
    - The function should accept two arguments: `key` and `value`. If the function returns a value, it will be used to update the dictionary; if it returns `nil`, the entry remains unchanged.

  Iterates through all key-value pairs in the dictionary and applies a callback function. Updates entries if the callback returns a non-nil value.

- `Dictionary:getIterator () -> function, table<string|table, unknown>`

  Returns an iterator function that can be used with a `for` loop to traverse the dictionary's key-value pairs. The iterator returns the key and value for each iteration.

---
#### Listenable

A `Listenable` is an object that enables other objects (listeners) to register themselves and receive notifications when specific events occur. Listeners can be either persistent or non-persistent: persistent listeners remain active until explicitly removed, while non-persistent listeners are automatically removed after they are invoked.

- `Listenable:getListenerCount () -> number`

  Returns the total number of registered listeners.

- `Listenable:registerListener (listener: Listener)`
  - `listener` A table containing the following properties:

    - `id` An (optional) unique identifier for the listener.
      - Useful for debugging and required for targeted removal.
    - `callback` A function that will be called when the event is invoked. This function should not return a value but can leverage closures or externally defined variables. Any errors raised by this function will be printed to the chat frame.
    - `persistent` A boolean indicating whether the listener is persistent or non-persistent. This property is optional, and defaults to `true`.
      - If `false`, the listener is removed after being invoked.

  Registers a new listener whose callback function will be invoked when the `Listenable` object is triggered. If the listener is persistent, it will remain active until explicitly removed; if it is non-persistent, it will be removed after being invoked.

- `Listenable:removeListener (id: string)`
  - `id` The identifier of the listener to be removed.

  Removes a listener by its identifier.

- `Listenable:invokeListeners (arguments?: Vector, executeAsync?: boolean)`
  - `arguments` A `Vector` containing the arguments that will be passed to the listeners' callback functions. 
    - This is optional, and can be omitted if no arguments are needed.
  - `executeAsync` A boolean indicating whether the listeners' callback functions should be executed asynchronously.
    - If omitted, defaults to `true`.

  Invokes all registered listeners, passing the provided arguments to their callback functions. Non-persistent listeners are automatically removed after execution. The invocation is asynchronous by default, but can be made synchronous by setting `executeAsync` to `false`.

---
#### Vector

A vector is a mutable array-like data structure that supports indexed access. It is a key component of the framework's data model, and is used extensively in plugin development.

- `Vector (initialValues?: table) -> Vector`
  - `initialValues` An optional table containing the initial values for the vector.
  - If omitted, the vector starts empty.

  Creates a new `Vector` instance with the optional initial values.

- `Vector:getSize () -> number`

  Returns the number of elements in the vector.

- `Vector:getIterator () -> function, table<number, unknown>`

  Returns an iterator function that can be used with a `for` loop to traverse the vector elements. The iterator returns the index and value for each iteration.

- `Vector:getElement (index: number) -> unknown?`
  - `index` The index of the element to retrieve.

  Returns the value at the specified index. If the index does not exist in the vector, `nil` is returned.

- `Vector:insertElement (element: unknown, position?: number)`
  - `element` The element to insert into the vector.
  - `position` The position at which to insert the element.
    - If omitted, the element is inserted at the end of the vector.

  Inserts an element into the vector at the specified position. If the position is omitted, the element is inserted at the end of the vector.

- `Vector:removeElement (index?: number)`
  - `index` The index of the element to remove.
    - If omitted, the last element is removed.

  Removes an element from the vector at the specified index. If the index is omitted, the last element is removed.

- `Vector:forEach (callback: (index: number, value: unknown) -> unknown?)`
  - `callback` A function that will be called for each element in the vector.
    - The function should accept two arguments: `index` and `value`. If the function returns a value, it will be used to update the vector; if it returns `nil`, the element remains unchanged.

  Iterates over all elements in the vector and applies a callback function. Updates elements if the callback returns a non-nil value.

- `Vector:containsElement (searchValue: unknown) -> boolean`
  - `searchValue` The value to search for in the vector.

  Checks whether the vector contains the specified value. Returns `true` if the value is found, `false` otherwise.

- `Vector:unpackElements () -> ...`

  Unpacks and returns all elements in the vector.

- `Vector:toArray () -> table<number, unknown>`

  Returns the vector values as a table. The returned table is a copy of the original vector's values.

---
### Functions

This section details the various utility functions provided by the framework. These functions are designed to facilitate addon development by offering a variety of common operations. Each function is exposed to the global namespace and can be directly invoked from within your plugin or addon.

- `flattenTable (target: table) -> table`
  - `target` The table that should be flattened.

  Flattens a table recursively into a single table, using a nested key scheme to represent the original table's structure. Returns a new table with the flattened structure.

  > If a key starts with `$`, it acts as a breaking point. The value of that key, and any nested tables, will be stored in their original forms.

- `integrateTable (base: table, source: table, mode: string) -> table`
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

- `split (target: string, separator: string, pieces?: number) -> Vector`
  - `target` The string to be split.
  - `separator` The string to use as the separator.
  - `pieces` The number of pieces to split the string into (optional).
    - If omitted, an unbounded number of pieces is returned.

  Splits a string into a set of substrings based on the specified separator. Returns the resulting substrings as a `Vector` object.

- `traverseTable (target: table, steps: table, mode?: string) -> unknown`
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

This section provides a description of the enumeration constants used within the framework, which are accessible through the global `ENUM` variable. Enumerations are a way of defining a set of named values, which can represent various states or options within the framework. By using enumerations, the code gains clarity and maintainability, as these named values are more descriptive than using arbitrary numbers or strings. 

The purpose of defining these enumerations is to create an abstraction layer that shields the framework, and the plugins that rely on it, from potential changes in the underlying values. This abstraction allows for future modifications to be made with minimal impact on the existing codebase, ensuring that any changes in these values are centralized and do not require extensive refactoring of the code that relies on them.

---
`ENUM.ANCHOR_POINT`

Provides numerical representations of anchor points used for positioning UI elements.

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

---
`ENUM.EXPANSION_LEVEL`

Provides numerical representations of expansion levels.

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

---
`ENUM.ITEM_BIND`

Provides numerical representations of item bindings.

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

---
`ENUM.ITEM_CLASS`

Provides numerical representations of item types.

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

---
`ENUM.ITEM_QUALITY`

Provides numerical representations of item qualities.

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

---
`ENUM.LOOT_SLOT_TYPE`

Provides numerical representations of loot slot types.

```lua
ENUM.LOOT_SLOT_TYPE = {
      NONE = Enum.LootSlotType.None,
      ITEM = Enum.LootSlotType.Item,
     MONEY = Enum.LootSlotType.Money,
  CURRENCY = Enum.LootSlotType.Currency
}
```

---
`ENUM.TRADESKILL_SUBTYPE`

Provides numerical representations of tradeskill item subtypes.

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
