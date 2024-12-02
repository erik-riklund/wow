# Backbone
*Version ? (work in progress)*
### A World of Warcraft Addon Development Framework

Backbone is a lightweight framework designed to simplify the development of World of Warcraft addons. It provides developers with a powerful toolkit for building robust, efficient, and maintainable addons.

## Table of contents

1. [Introduction](#1-introduction)
    - [Features](#features)
    - [Getting started](#getting-started)
    - [Usage examples](#usage-examples)
      - [Hello world](#hello-world)
      - [Event listeners](#event-listeners)
2. [Framework reference](#2-framework-reference)
    - [Static resources](#static-resources)
    - [Methods](#methods)
    - [Classes](#classes)
    - [Enumerations](#enumerations)
3. [Plugin API reference](#3-plugin-api-reference)
4. [Settings API reference](#4-settings-api-reference)
    - [Manager](#settingsmanager)
    - [Category](#settingscategory)
5. [Developer resources](#5-developer-resources)
6. [Contributing](#6-contributing)
7. [License](#7-license)
8. [Acknowledgements](#8-acknowledgements)

## 1. Introduction

Backbone is built to streamline the process of addon development by offering:

- A clean, intuitive and performant structure.
- Utilities for common tasks such as event handling, configuration, and data storage.
- Compatibility with the latest versions of World of Warcraft.

Whether you're creating your first addon or enhancing an existing one, Backbone helps you focus on functionality instead of boilerplate code.

*Extend and enhance the introduction to make it interesting!*

### Features

- **Lightweight**: Minimal overhead to ensure your addon remains performant.
- **Performance**: The framework is designed with performance in mind, enabling and encouraging developers to create addons that load dynamically when needed, optimizing gameplay by minimizing initial loading times.
- **Inter-addon cooperation**: Designed to promote seamless interaction between addons, enabling developers to build collaborative and interconnected features.
- **Event handling**: Simplified registration and handling of WoW API events to streamline event-driven programming.
- **State management**: Built-in support for managing and persisting addon data (saved variables).
- **Configuration handling**: Offers robust tools for managing addon configuration, along with a simplified API for seamlessly integrating settings into the standard WoW interface.
- **Localization support**: Provides efficient handling of localized strings, making it easy to create addons that support multiple languages and regions.

The framework not only emphasizes performance but also fosters a cooperative ecosystem where addons can communicate and integrate efficiently. Developers can leverage shared data through services and channels, enabling richer experiences for players while maintaining compatibility.

---
### Getting started

*Provide information about extensions to enable full typing during development.*

---
### Usage examples

Each example use the variable `plugin` to represent an active plugin.

```lua
--The name of the plugin must match the name of your addon folder.
local plugin = backbone.createPlugin 'MyAddon'
```

---
#### Hello world
As per programming standards, here is a basic "Hello world" example.

```lua
plugin:onReady(function () print 'Hello world' end)
```

---
#### Event listeners
This example demonstrates how to register an event listener using the [`registerEventListener`](#pluginregistereventlistenerevent-string-listener-listener) method. The `PLAYER_ENTERING_WORLD` event triggers a welcome message that includes the player's name.

```lua
plugin:registerEventListener(
  'PLAYER_ENTERING_WORLD', {
    --The function that is executed when the event occur.
    callback = function() print ('Welcome '.. UnitName ('player')) end

    --The identifier is used for error reporting and removing listeners.
    identifier = 'PlayerGreeting', -- (optional)

    --If explicitly set to `false`, the listener is removed after being invoked.
    persistent = false -- (optional, default = true)
  }
)
```

---
#### Using network channels
*Add a description of what the example demonstrates.*

```lua
--The second parameter (options) is optional. This example simply
--demonstrates the default values for the channel options.

plugin:createChannel ('A_CUSTOM_CHANNEL', { async = true, internal = false })
```

*Add a description of what the example demonstrates.*

```lua
local firstArg = true
local secondArg = 'Eh?'

plugin:invokeChannelListeners ('A_CUSTOM_CHANNEL', firstArg, secondArg)
```

*Add a description of what the example demonstrates.*

```lua
plugin:registerChannelListener (
  'A_CUSTOM_CHANNEL', {
    callback = function() --[[ do something... ]] end
    identifier = 'ChannelExample', -- (optional)
    persistent = false -- (optional, default = true)
  }
)
```

---
## 2. Framework reference

### Static resources

#### `backbone.activeLocale`
The active locale of the game client, represented as a string (`enUS`, `deDE`, etc.).

---
#### `backbone.currentExpansion`
The current expansion level of the game, represented as a number (see [`EXPANSION_LEVEL`](#enumexpansion_level)).

---
### Methods

#### `backbone.createPlugin(name: string) -> plugin: Plugin`
Creates a new plugin with the specified name. Throws an error if a plugin with that name already exists.
- `name` The desired name of the plugin. *Must match the folder name of your addon.*

---
#### `backbone.executeTask(task: Task)`
Executes a task immediately in a blocking manner.
- `task` A task object (see [`Task`](#task)).

---
#### `backbone.executeTaskAsync(task: Task)`
Schedules a task for asynchronous execution.
- `task` A task object (see [`Task`](#task)).

---
#### `backbone.onAddonLoaded(addon: string, callback: function)`
?

---
#### `backbone.getItemId(link: string) -> itemId: string`
Extracts the item ID from an item link.
- `link` The item link.

---
#### `backbone.getItemInfo(item: number|string) -> itemInfo: ItemData`
Retrieves detailed information about an item specified by its ID or link. Combines basic and detailed item data into a structured format (see [`ItemData`](#itemdata)).
- `item` An item ID or link.

---
#### `backbone.getItemLevel(info: number|string) -> actualItemLevel: number`
Retrieves the actual item level of the specified item.
- `info` The item link or ID for which to retrieve the item level.

---
#### `backbone.getLootCount() -> itemCount: number`
Returns the number of items currently available in the loot window.

---
#### `backbone.getLootslotInfo(slot: number) -> slotInfo: LootslotInfo`
Retrieves detailed information about a specific loot slot. Combines data from multiple APIs into a structured format (see [`LootslotInfo`](#lootslotinfo)).
- `slot` The index of the loot slot (1-based).

---
#### `backbone.isFishingLoot() -> boolean`
Returns true if the loot window is related to fishing.

---
#### `backbone.lootSlot(slot: number)`
Loots the specified slot in the loot window.
- `slot` The index of the loot slot (1-based).

---
#### `backbone.throw(exception: string, ...: string)`
Throws a formatted exception with the specified message, formatting it if additional arguments are provided, and raises an error with a stack trace at level 3 for better debugging.
- `exception` The exception message to throw. Supports formatting placeholders.
- `...` Additional arguments to format the exception message. *`optional`*

---
### Classes

#### `Dictionary`

?

#### `Listenable`

?

#### `Vector`

?

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

### Object types

*Add a description of this section.*

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

---
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

---
#### `Listener`

Represents an entity that observes and responds to events or updates from a [`Listenable`](#listenable) object, such as events or channels.

- `callback` The callback function to be invoked when the listener is triggered.
- `identifier?` A unique identifier for the listener.
  - If omitted, the listener will be anonymous (not eligible for targeted removal).
- `persistent?` Indicates whether the listener should persist after being invoked.
  - If true, the listener remains active; if false, it is automatically removed after one invocation.
  - Defaults to true if not specified.

---
#### `Task`

Represents a unit of work to be executed, either synchronously or asynchronously.

- `callback` The callback function to be executed when the task runs.
- `arguments?` Arguments to pass to the callback function.
- `identifier?` A unique identifier for the task, used for debugging.

---
## 3. Plugin API reference

#### `plugin:getId() -> id: string`
Retrieves the unique identifier of the plugin.

---
#### `plugin:getName() -> name: string`
Retrieves the display name of the plugin.

---
#### `plugin:onReady(callback: function)`

Registers a function to be executed when the plugin is fully initialized. This method is ideal for centralizing and organizing addon startup logic, ensuring that your code runs at the correct time during the game's loading process. Can be used any number of times; the registered functions are executed in the order they were added.

- `callback`: A function that will be invoked when the plugin is loaded. The function can be used to set up initial states, register event listeners, or perform other setup tasks. The callback does not take any arguments by default but can leverage closures or external variables for context.

---
#### `plugin:registerEventListener(event: string, listener: Listener)`
Registers a listener for a specified game event.
- `event`: The name of the event to listen for (e.g., `PLAYER_ENTERING_WORLD`, `CHAT_MSG_SAY`). This is case-sensitive and must match the game's standard event names.
- `listener`: A table defining the behavior of the listener. See [`Listener`](#listener) for details on its structure and options.

---
#### `plugin:removeEventListener(event: string, identifier: string)`
Removes a previously registered event listener for a specified event.
- `event`: The name of the event associated with the listener you want to remove.
- `identifier`: The unique identifier assigned to the listener when it was registered. This is required to precisely target and remove the specific listener.

---
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
