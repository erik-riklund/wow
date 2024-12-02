# Backbone
*Version ? (work in progress)*
### A World of Warcraft addon development framework

Backbone is a lightweight framework designed to simplify the development of World of Warcraft addons. It provides a powerful toolkit that can be utilized to build robust, efficient, and maintainable addons.

*Extend the summary?*

## Table of contents

1. [Introduction](#1-introduction)
    - [Features](#features)
    - [Getting started](#getting-started)
    - [Usage examples](#usage-examples)
      - [Event listeners](#event-listeners)
      - [Network channels](#using-network-channels)
2. [Framework reference](#2-framework-reference)
    - [Static resources](#static-resources)
    - [Methods](#methods)
    - [Classes](#classes)
    - [Enumerations](#enumerations)
3. [Plugin API reference](#3-plugin-api-reference)
    - [Event handling](#event-handling)
    - [Network channels](#network-channels)
    - [State management](#state-management)
4. [Settings API reference](#4-settings-api-reference)
5. [Developer resources](#5-developer-resources)
6. [Contributing](#6-contributing)
7. [License](#7-license)
8. [Acknowledgements](#8-acknowledgements)

## 1. Introduction

Backbone is built to streamline the process of addon development by offering:

- A clean, easy-to-use and performant structure.
- Utilities for common tasks such as event handling, configuration, and data storage.
- Compatibility with the latest versions of World of Warcraft.

Whether you're creating your first addon or enhancing an existing one, Backbone helps you focus on functionality instead of boilerplate code.

*Extend and enhance the introduction to make it interesting!*

### Features

- **Lightweight**: Minimal overhead to ensure addons remains performant.
- **Performance**: The framework is designed with performance in mind, enabling and encouraging developers to create addons that load dynamically when needed, optimizing gameplay by minimizing initial loading times.
- **Inter-addon cooperation**: Designed to promote seamless interaction between addons, enabling developers to build collaborative and interconnected features.
- **Event handling**: Simplified registration and handling of WoW API events to streamline event-driven programming.
- **State management**: Built-in support for managing and persisting addon data (saved variables).
- **Configuration handling**: Offers robust tools for managing addon configuration, along with a simplified API for seamlessly integrating settings into the standard configuration interface.
- **Localization support**: Provides efficient handling of localized strings, making it easy to create addons that support multiple languages and regions.

The framework not only emphasizes performance but also fosters a cooperative ecosystem where addons can communicate and integrate efficiently. Developers can leverage shared data through services and channels, enabling richer experiences for players while maintaining compatibility.

---
### Getting started

*Provide information about extensions to enable full typing during development.*

---
### Usage examples

*Extend this introduction.* Each example use the variable `plugin` to represent an active plugin.

```lua
--The name of the plugin must match the name of your addon folder.
local plugin = backbone.createPlugin 'MyAddon'
```

As per programming conventions, here is a basic 'Hello World' example. While the example itself is simple and straightforward, the [`onReady`](#pluginonreadycallback-function) method plays a critical role. This method is essential for initializing your addon, as it ensures that all registered callbacks are executed only after everything is fully loaded, including saved variables.

```lua
plugin:onReady(function () print 'Hello world' end)
```

---
#### Event listeners
The following example demonstrates how to register an event listener for the `PLAYER_ENTERING_WORLD` event. When the event occurs, the specified callback function is executed, displaying a personalized welcome message using the player's name. An optional identifier, *PlayerGreeting*, is assigned to the listener, allowing for easy debugging or removal if necessary. Additionally, the listener is configured to be non-persistent by setting the `persistent` option to `false`, meaning it will automatically be removed after being triggered once. By default, listeners are persistent unless explicitly set otherwise.

```lua
plugin:registerEventListener(
  'PLAYER_ENTERING_WORLD', {
    callback = function() print ('Welcome '.. UnitName ('player')) end
    identifier = 'PlayerGreeting', -- (optional)
    persistent = false -- (optional, default = true)
  }
)
```

---
#### Using network channels
Network channels enable plugins to establish and manage communication pathways for transmitting messages or data, either within an addon (if internal) or between addons. By default, channels are not limited to internal use, and their listeners operate asynchronously.

```lua
plugin:createChannel ('A_CUSTOM_CHANNEL', { async = true, internal = false })
```

The following example demonstrates invoking all listeners on the channel `A_CUSTOM_CHANNEL` and passing the variables `first` and `second` as arguments. Each registered listener will receive these arguments when its callback is executed. If the channel is designed to communicate with other addons, it is essential to provide clear documentation for the arguments being passed.

```lua
local first = true
local second = 52

plugin:invokeChannelListeners ('A_CUSTOM_CHANNEL', first, second)
```

The example below demonstrates how to register a listener for the channel `A_CUSTOM_CHANNEL`. An optional identifier, *ChannelExample*, is assigned to the listener, allowing for easier debugging or removal. Additionally, the listener is set to be non-persistent, meaning it will be automatically removed after being triggered once. By default, listeners are persistent, but this can be adjusted by explicitly setting the `persistent` option to `false`.

```lua
plugin:registerChannelListener (
  'A_CUSTOM_CHANNEL', {
    callback = function() --[[ do something... ]] end
    identifier = 'ChannelExample', -- (optional)
    persistent = false -- (optional, default = true)
  }
)
```

## 2. Framework reference

### Static resources

#### `backbone.activeLocale`
The active locale of the game client, represented as a string (`enUS`, `deDE`, etc.).

#### `backbone.currentExpansion`
The current expansion level of the game, represented as a number (see [`EXPANSION_LEVEL`](#enumexpansion_level)).

---
### Methods

#### `backbone.createPlugin(name: string) -> plugin: Plugin`
Creates a new plugin with the specified name. Throws an error if a plugin with that name already exists.
- `name` The desired name of the plugin. *Must match the folder name of your addon.*

#### `backbone.hasPlugin(name: string) -> hasPlugin: boolean`
Checks if a plugin with the specified name exists.
- `name` The name of the addon.

#### `backbone.onAddonLoaded(addon: string, callback: function)`
Registers a callback to be invoked when the specified addon is fully loaded.
- `addon` The name of the addon.
- `callback` The function to be executed.

---
#### `backbone.executeTask(task: Task)`
Executes a task synchronously, blocking execution until the task is completed. This method is suitable for scenarios where immediate execution and completion of the task are required before proceeding to the next step.
- `task` The task object (see [`Task`](#task)).

#### `backbone.executeTaskAsync(task: Task)`
Executes a task asynchronously, allowing other operations to continue while the task is being processed. This method is ideal for tasks that may take time to complete or for maintaining smooth gameplay performance without blocking other operations.
- `task` The task object (see [`Task`](#task)).

---
#### `backbone.getItemId(link: string) -> itemId: string`
Extracts the item ID from an item link.
- `link` The item link.

#### `backbone.getItemInfo(item: number|string) -> itemInfo: ItemData`
Retrieves detailed information about an item specified by its ID or link. Combines basic and detailed item data into a structured format (see [`ItemData`](#itemdata)).
- `item` An item ID or link.

#### `backbone.getItemLevel(info: number|string) -> actualItemLevel: number`
Retrieves the actual item level of the specified item.
- `info` The item link or ID for which to retrieve the item level.

#### `backbone.getLootslotInfo(slot: number) -> slotInfo: LootslotInfo`
Retrieves detailed information about a specific loot slot. Combines data from multiple APIs into a structured format (see [`LootslotInfo`](#lootslotinfo)).
- `slot` The index of the loot slot (1-based).

---
#### `backbone.throw(exception: string, ...: string)`
Throws a formatted exception with the specified message, formatting it if additional arguments are provided, and raises an error with a stack trace at level 3 for better debugging.
- `exception` The exception message to throw. Supports formatting placeholders.
- `...` Additional arguments to format the exception message. *`optional`*

---
### Classes

Each class listed below features a constructor, which is a globally accessible function named after the class. If a constructor is not explicitly documented, it is parameterless. For classes that support object creation without arguments, the shorthand syntax `new 'ClassName'` provides a convenient alternative.

---
#### Dictionary

*Add a description of the class.*

---
#### Listenable

The `Listenable` class provides a foundational system for registering, managing, and invoking listeners. It is designed to handle event-driven behavior efficiently, allowing developers to attach custom logic to specific triggers or events.

##### `Listenable:getListenerCount() -> count: number`
Returns the number of listeners currently registered with the object.

##### `Listenable:registerListener(listener: Listener)`
Registers a new listener to the current object.
- `listener` The listener that should be registered (see [`Listener`](#listener)).

##### `Listenable:removeListener(id: string)`
Removes a registered listener based on its unique identifier.
- `id` The unique identifier for the listener targeted for removal.

##### `Listenable:invokeListeners(arguments?: Vector, async?: boolean)`
Invokes all registered listeners, passing the provided arguments to their callback functions. Non-persistent listeners are automatically removed after execution.
- `arguments?` An optional list (table) of arguments to pass to each listener's callback function. If omitted, no arguments are passed.
- `async?` Determines whether the invocation is asynchronous (default: `true`). If explicitly set to `false`, listeners are invoked synchronously, blocking further execution until all listeners have completed.

---
#### Vector

*Add a description of the class.*

##### `Vector(initialValues?: table) -> Vector`

---
### Enumerations

The framework provides both new enumerations and an abstraction layer on top of some of the game’s standard  enumerations. This abstraction simplifies code maintenance by shielding developers from changes in the underlying enumerations that may occur in future game updates.

#### `ENUM.ANCHOR_POINT`

Represents anchor points for positioning UI elements.

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

#### `ENUM.EXPANSION_LEVEL`

Represents the expansion levels in the game, mapping each expansion to its corresponding numerical identifier.

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

#### `ENUM.ITEM_BIND`

Represents the binding types for items in the game.

```lua
ENUM.ITEM_BIND = {
  ---The item has no binding.
        NONE = Enum.ItemBind.None,
  ---The item becomes soulbound when acquired.
  ON_ACQUIRE = Enum.ItemBind.OnAcquire,
  ---The item becomes soulbound when equipped.
    ON_EQUIP = Enum.ItemBind.OnEquip,
  ---The item becomes soulbound when used.
      ON_USE = Enum.ItemBind.OnUse,
  ---The item is bound to a specific quest.
       QUEST = Enum.ItemBind.Quest,
  ---The item is bound to the player's World of Warcraft account.
     ACCOUNT = Enum.ItemBind.ToWoWAccount,
  ---The item is bound to the player's Battle.net account.
     WARBAND = Enum.ItemBind.ToBnetAccount,
  ---The item is bound to the player's Battle.net account until equipped.
  WARBAND_EQ = Enum.ItemBind.ToBnetAccountUntilEquipped
}
```

#### `ENUM.ITEM_CLASS`

Represents the main categories of items in the game.

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

#### `ENUM.ITEM_QUALITY`

Represents the quality levels of items in the game.

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

#### `ENUM.LOOTSLOT_TYPE`

Represents the different types of loot slots in the game.

```lua
ENUM.LOOTSLOT_TYPE = {
      NONE = Enum.LootSlotType.None,
      ITEM = Enum.LootSlotType.Item,
     MONEY = Enum.LootSlotType.Money,
  CURRENCY = Enum.LootSlotType.Currency
}
```

#### `ENUM.TRADESKILL_SUBTYPE`

Represents the subtypes of trade skill items used in crafting professions.

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

---
### Object types

*Add a description of this section.*

#### `ChannelOptions`
Defines the configuration settings for a network channel, specifying its behavior and accessibility.
- `async?` Indicates whether the channel operates asynchronously.
  - If `false`, listeners are processed synchronously, ensuring immediate execution.
  - Defaults to `true` if not specified.
- `internal?` Determines the accessibility of the channel.
  - If `true`, the channel is restricted to internal use, allowing only the owning plugin to interact with it.
  - Defaults to `false` if not specified.

#### `ItemData`
Represents a data structure containing detailed information about an item.
- `id: number` The item's ID.
- `name: string` The localized name of the item.
- `link: string` The localized link of the item.
- `quality: number` The [`ITEM_QUALITY`](#enumitem_quality) code for the item.
- `itemLevel: number` The actual item level of the item.
- `baseItemLevel: number` The base item level, not including upgrades.
- `requiredPlayerLevel: number` The minimum level required to use the item, or `0` if there is no level requirement
- `localizedType: string` The localized type name of the item: Armor, Weapon, Quest, etc.
- `localizedSubtype: string` The localized sub-type name of the item: Bows, Guns, Staves, etc.
- `stackCount: number` The max amount of an item per stack, e.g. 200 for Runecloth.
- `equipLocation: string` The inventory equipment location in which the item may be equipped (e.g. `INVTYPE_HEAD`), or an empty string if it cannot be equipped.
- `textureId: number` The texture ID for the item icon.
- `sellPrice: number` The vendor price in copper, or `0` for items that cannot be sold.
- `typeId: number` The numeric ID of `localizedType`.
- `subtypeId: number` The numeric ID of `localizedSubtype`.
- `bindType: number` When the item becomes soulbound (see [`ITEM_BIND`](#enumitem_bind)).
- `expansionId: number` The expansion ID (see [`EXPANSION_LEVEL`](#enumexpansion_level))
- `setId: number?` The ID of the set that the item belong to, if any.
- `isCraftingReagent: boolean` Whether the item can be used as a crafting reagent.

#### `LootslotInfo`
Represents a data structure containing detailed information about a loot slot.
- `icon: string` The path of the graphical icon for the item.
- `name: string` The localized name of the item.
- `link: string` The localized link of the item.
- `slotType: number` Numerical representation of the loot type for a given loot slot (see [`LOOTSLOT_TYPE`](#enumlootslot_type)).
- `quantity: number` The quantity of the item in a stack. *Note: Quantity for coin is always 0.*
- `currencyId: number?` The identifying number of the currency loot in slot, if applicable. *Note: Returns nil for slots with coin and regular items.*
- `quality: number` The [`ITEM_QUALITY`](#enumitem_quality) code for the item.
- `locked: boolean` Whether the player is eligible to loot this item or not. Locked items are by default shown tinted red.
- `isQuestItem: boolean` Self-explanatory.
- `questId: number` The identifying number for the quest.
- `isQuestActive: boolean` True if the item starts a quest that the player is not currently on.

#### `Listener`
Represents an entity that observes and responds to events or updates from a [`Listenable`](#listenable) object, such as events or channels.
- `callback` The callback function to be invoked when the listener is triggered.
- `identifier?` A unique identifier for the listener.
  - If omitted, the listener will be anonymous (not eligible for targeted removal).
- `persistent?` Indicates whether the listener should persist after being invoked.
  - If true, the listener remains active; if false, it is automatically removed after one invocation.
  - Defaults to true if not specified.

#### `Task`
Represents a unit of work to be executed, either synchronously or asynchronously.
- `callback` The callback function to be executed when the task runs.
- `arguments?` Arguments to pass to the callback function.
- `identifier?` A unique identifier for the task, used for debugging.

## 3. Plugin API reference

*Add a description of this section.*

#### `plugin:getId() -> id: string`
Retrieves the unique identifier of the plugin.

#### `plugin:getName() -> name: string`
Retrieves the display name of the plugin.

---
### Event handling

*Add a description of this section.*

#### `plugin:onReady(callback: function)`
Registers a function to be executed when the plugin is fully initialized. This method is ideal for centralizing and organizing addon startup logic, ensuring that your code runs at the correct time during the game's loading process. Can be used any number of times; the registered functions are executed in the order they were added.
- `callback`: A function that will be invoked when the plugin is fully loaded, saved variables included. The callback does not take any arguments by default, but can leverage closures or external variables for context.

#### `plugin:registerEventListener(event: string, listener: Listener)`
Registers a listener for a specified game event.
- `event`: The name of the event to listen for. This is case-sensitive and must match the game's standard event names.
- `listener`: A table defining the behavior of the listener. See [`Listener`](#listener) for details on its structure and options.

#### `plugin:removeEventListener(event: string, identifier: string)`
Removes a previously registered event listener for a specified event.
- `event`: The name of the event associated with the listener you want to remove.
- `identifier`: The unique identifier assigned to the listener when it was registered. This is required to precisely target and remove the specific listener.

---
### Network channels

*Add a description of this section.*

#### `plugin:createChannel(name: string, options?: ChannelOptions)`
Creates a new network channel with the specified name and configuration options.
- `name` The unique name of the channel. This name is used to reference the channel for invoking or registering and removing listeners.
- `options?` Configuration settings for the channel's behavior and accessibility (see [`ChannelOptions`](#channeloptions)).

#### `plugin:registerChannelListener(channel: string, listener: Listener)`
Registers a listener to the specified channel.
- `channel` The name of the channel to which the listener should be registered.
- `listener` The listener object containing a callback and optional properties (see [`Listener`](#listener)).

#### `plugin:removeChannelListener(channel: string, id: string)`
Removes a listener from the specified channel.
- `channel` The name of the channel from which the listener should be removed.
- `id` The unique identifier of the listener targeted for removal.

#### `plugin:invokeChannelListeners(channel: string, ...: unknown)`
Invokes all listeners registered to a specified channel, passing arguments to their callback functions.
- `channel` The name of the channel whose listeners should be invoked.
- `...` Any number of arguments to pass to the listeners. These arguments will be received by each listener in the order they are passed.

---
### State management

*Add a description of this section.*

#### `plugin:getAccountVariable(key: string) -> value: unknown`
?

#### `plugin:setAccountVariable(key: string, value: unknown)`
?

#### `plugin:getCharacterVariable(key: string) -> value: unknown`
?

#### `plugin:setCharacterVariable(key: string, value: unknown)`
?

## 4. Settings API reference

*Add a description of this section.*

#### `SettingsManager`

*List the available methods here.*

#### `SettingsCategory`

*List the available methods here.*

## 5. Developer resources

### Download locations

*Links to download locations and the Discord server.*

### Discord

https://discord.gg/JaHq2wWweS

## 6. Contributing

Contributions and suggestions are encouraged! For major changes, please open an issue prior to forking and branching the repository to discuss what you would like to add or modify.

## 7. License

This project is licensed under the GNU GPL License. See the [LICENSE](LICENSE.md) file for more information.

## 8. Acknowledgements

- Inspired by the simplicity of frameworks in other environments.
- Thanks to the World of Warcraft developer community for documentation and inspiration.
