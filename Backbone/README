# Backbone
*Version 1.0.0*
### A World of Warcraft Addon Development Framework

Backbone is a lightweight, modular framework designed to simplify the development of World of Warcraft addons. It provides developers with a powerful toolkit for building robust, efficient, and maintainable addons.

## Table of contents

1. [Introduction](#1-introduction)
2. [Features](#2-features)
3. [Getting started](#3-getting-started)
4. [Usage](#4-usage)
5. [Framework API reference](#5-framework-api-reference)
    - 5.1 [Static resources](#51-static-resources)
    - 5.2 [Enumerations](#52-enumerations)
    - 5.3 [Methods](#53-methods)
6. [Plugin API reference](#6-plugin-api-reference)
7. [Developer resources](#7-developer-resources)
8. [Contributing](#8-contributing)
9. [License](#9-license)
10. [Acknowledgements](#10-acknowledgements)

## 1. Introduction

Backbone is built to streamline the process of addon development for World of Warcraft by offering:

- A clean, intuitive and performant structure.
- Utilities for common tasks such as event handling, configuration, and data storage.
- Compatibility with the latest versions of World of Warcraft.

Whether you're creating your first addon or enhancing an existing one, Backbone helps you focus on functionality instead of boilerplate code. [TODO: Extend and enhance the introduction]

## 2. Features

- **Performance**: The framework is designed with performance in mind, enabling and encouraging developers to create addons that load dynamically when needed, optimizing gameplay by minimizing initial loading times.
- **Event handling**: Simplified registration and handling of WoW API events to streamline event-driven programming.
- **State management**: Built-in support for managing and persisting addon data (saved variables).
- **Configuration handling**: Offers robust tools for managing addon configuration, along with a simplified API for seamlessly integrating settings into the standard WoW interface.
- **Localization support**: Provides efficient handling of localized strings, making it easy to create addons that support multiple languages and regions.
- **Lightweight**: Minimal overhead to ensure your addon remains performant.
- **Inter-addon cooperation**: Designed to promote seamless interaction between addons, enabling developers to build collaborative and interconnected features.

The framework not only emphasizes performance but also fosters a cooperative ecosystem where addons can communicate and integrate efficiently. Developers can leverage shared data through services and channels, enabling richer experiences for players while maintaining compatibility.

## 3. Getting started

?

### .TOC file

*Describe the basics for the table of contents file.*

## 4. Usage

### Hello world

As per programming standards, here's a "Hello world" example.

```lua
--The name of the plugin must match the name of your addon folder.
local plugin = backbone.createPlugin 'HelloWorld'
plugin:onLoad(function () print 'Hello world' end)
```

## 5. Framework API reference

### 5.1 Static resources

#### `backbone.activeLocale`

The active locale of the game client, represented as a string (e.g., "enUS", "deDE").

#### `backbone.currentExpansion`

The current expansion level of the game, represented as a number (see [EXPANSION_LEVEL](#enumexpansion_level)).

### 5.2 Enumerations

The framework provides both new enumerations and an abstraction layer on top of some of World of Warcraft’s standard game enumerations. This abstraction simplifies code maintenance by shielding developers from changes in the underlying enumerations that may occur in future game updates.

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

#### `ENUM.LOOT_SLOT_TYPE`

Represents the different types of loot slots in the game.

```lua
ENUM.LOOT_SLOT_TYPE = {
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

### 5.3 Methods

#### `backbone.createPlugin(name): Plugin`

Initializes a new plugin with the specified name. Returns a `Plugin` object.

- `name` (string): The name of your plugin. *Must match the actual addon folder name.*

#### `backbone.hasPlugin(name): boolean`

Checks if a plugin with the given name is registered. Returns true if the plugin exists, false otherwise.

- `name` (string): The name of the plugin to check.

#### `backbone.getEnvironment(): 'development'|'production'`

?

## 6. Plugin API reference

#### `plugin:onLoad(callback)`

?

## 7. Developer resources

?

## 8. Contributing

Contributions and suggestions are encouraged! For major changes, please open an issue prior to forking and branching the repository to discuss what you’d like to add or modify.

## 9. License

This project is licensed under the GNU GPL License. See the [LICENSE](LICENSE) file for more information.

## 10. Acknowledgements

- Inspired by the simplicity of frameworks in other environments.
- Thanks to the World of Warcraft developer community for documentation and inspiration.
