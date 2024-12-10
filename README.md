# Backbone
Version `1.0.0` (*work in progress*)

---

- [Introduction](#introduction)
- [Developer community](#developer-community)
- [Getting started and beyond](#getting-started-and-beyond)

  - [Initialization](#initialization)
  - [Event handling](#event-handling)
  - [Framework channels](#framework-channels)
  - [Localization](#localization)
  - [State management](#state-management)
  - [Plugin settings](#plugin-settings)
  - [Services](#services)

- [Configuration - user interface integration](#configuration---user-interface-integration)
- [Conditional loading of addons](#conditional-loading-of-addons)
- [Developer resources](#developer-resources)
- [Reference documentation](#reference-documentation)

## Introduction

Backbone is a framework designed to simplify and enhance addon development. By handling repetitive tasks, basic setup, and performance optimizations, it allows you to focus on building the features and functionality that matter most. The framework’s clear and intuitive structure encourages clean, organized code, making it easier to maintain and expand your projects over time.

Whether you're a seasoned developer or just starting out, Backbone supports creating high-quality addons with ease. Beyond the technical tools, it fosters a welcoming community where developers can collaborate, share ideas, and grow together.

### Features

- Conditional loading of addons to improve performance.
- Streamlined plugin initialization process for a smooth development experience.
- Effortless event handling to enable dynamic responses to game events.
- Framework channels facilitate communication between addons.
- Efficient state management for persistent data storage across game sessions.
- Comprehensive localization support to enable addons to reach a broader audience.
- Easy handling of settings for plugin customization, along with configuration management integrated into the standard UI.

## Developer community

The Backbone community is built on a foundation of respect, collaboration, and empowerment. Whether you’re seeking assistance, showcasing your latest project, or connecting with like-minded developers, the community is here to support you every step of the way. By fostering open communication and teamwork, we aim to create a vibrant, inclusive environment where developers can learn, grow, and share knowledge.

> [Join the Backbone community on Discord](https://discord.gg/JaHq2wWweS) 💬

## Getting started and beyond

The `Plugin` class serves as the foundation of the framework, offering a comprehensive suite of tools to simplify addon development. By managing the core lifecycle and underlying processes, it frees you to focus on creating innovative features and functionality.

```lua
-- The name of the plugin must match the name of the addon folder.
local plugin = backbone.createPlugin 'MyPlugin'
```

> In all examples throughout this guide, the `plugin` variable represents an active plugin instance.

## Initialization

The initialization process is a crucial part of the plugin lifecycle, ensuring that your addon is fully prepared and ready to function before any code is executed. This step is particularly important for modules such as the state manager or configuration handler, which depend on saved variables to operate correctly.

```lua
plugin:onReady(
  function ()
  -- The callback is executed when the plugin is fully initialized.
  end
)
```

If your plugin interacts with another addon, you can use `backbone.onAddonReady` to ensure that the target addon is completely loaded before executing related code.

```lua
backbone.onAddonReady(
  'SomeOtherAddon', function ()
    -- This callback will be executed when `SomeOtherAddon` is loaded.
  end
)
```

> By utilizing these methods, you can ensure that your plugin and its dependencies are initialized correctly, preventing errors caused by incomplete or missing data. This approach guarantees a smooth and seamless experience for players.

## Event handling

Event handling is a fundamental feature of the framework, enabling your plugin to respond dynamically to in-game events. By registering event listeners, you can define actions to execute when specific events occur, such as player interactions or changes in game state. This ensures seamless integration with the game's ecosystem.

### Registering an event listener

You can register event listeners using the `registerEventListener` method. This method requires an event name and a `Listener` object with the following properties:

* `callback` The function to execute when the event is triggered.
  - *The callback should accept parameters relevant to the event.*

* `identifier?` An optional unique identifier for the listener.
  - *If omitted, the listener will be anonymous (not eligible for targeted removal).*

* `persistent?` Specifies whether the listener remains active after being triggered.
  - *Defaults to `true`. Set to `false` to remove the listener after it executes once.*

```lua
plugin:registerEventListener (
  'SOME_EVENT', {
    persistent = true, -- default: true
    identifier = 'MyEventListener', -- optional

    callback = function (--[[ event-specific arguments ]])
      -- The callback will be executed when the event is triggered.
    end
  }
)
```

### Removing an event listener

To remove an event listener, use the `removeEventListener` method. Provide the event name and the identifier of the listener you want to remove:

```lua
plugin:removeEventListener ('SOME_EVENT', 'MyEventListener')
```

## Framework channels

Framework channels are a versatile feature of the Backbone framework, allowing you to establish communication pathways between different parts of your plugin or interact with other addons. These channels can be used to exchange data, trigger actions, and much more.

### Creating a framework channel

To create a new channel, use the `createChannel` method. This method requires a channel name and accepts an optional `ChannelOptions` object with the following properties:

* `internal?` Specifies whether the channel is restricted to the owning plugin.
  - *Defaults to `false`, making the channel accessible to all plugins.*

* `executeAsync?` Determines whether listeners on this channel are executed in the background (asynchronously) or immediately.
  - *Defaults to `true`, enabling background execution.*

```lua
plugin:createChannel (
  'MY_CHANNEL', {
    internal = false, -- optional
    executeAsync = true -- optional
  }
)
```

### Registering a channel listener

Listeners can be registered to a channel using the `registerChannelListener` method. This method requires the channel name and a `Listener` object with the following properties:

* `callback` The function to execute when the channel is invoked.
  - *The callback should accept parameters specific to the channel.*

* `identifier?` An optional unique identifier for the listener.
  - *If omitted, the listener will be anonymous (not eligible for targeted removal).*

* `persistent?` Specifies whether the listener remains active after being invoked.
  - *Defaults to `true`. Set to `false` to remove the listener after one execution.*

```lua
plugin:registerChannelListener (
  'MY_CHANNEL', {
    persistent = true, -- default: true
    identifier = 'MyChannelListener', -- optional
    callback = function (--[[ channel-specific arguments ]])
      -- The callback will be executed when the channel is invoked.
    end
  }
)
```

### Removing a channel listener

To remove a listener from a channel, use the `removeChannelListener` method. Provide the channel name and the identifier of the listener to remove:

```lua
plugin:removeChanneListener ('MY_CHANNEL', 'MyChannelListener')
```

### Invoking channel listeners

To trigger all listeners registered to a specific channel, use the `invokeChannelListeners` method. This method requires the channel name and can accept additional arguments specific to the channel.

```lua
plugin:invokeChannelListeners ('MY_CHANNEL', --[[ channel-specific argument, ... ]])
```

> When your addon use channels to transmit messages and payloads to other addons, it is important to document the arguments that each listener will receive.

## Localization

Localization enables your addon to reach a broader audience by translating text into different languages. The framework provides tools to manage localized strings, making it simple to define and retrieve text in multiple languages.

### Registering localized strings

To register localized strings for a specific language, use the `registerLocalizedStrings` method. This method allows you to add unique keys and their corresponding translations. If you register the same key multiple times, the framework will retain the original value and ignore subsequent additions.

```lua
plugin:registerLocalizedStrings (
  'enUS', {
    HELLO_WORLD = 'Hello world!',
    HELLO_WORLD2 = 'Hello world 2!',
    
    --[[ ... ]]
  }
)
```

> The `enUS` locale serves as the default language for the framework.

### Adding external translations

Translations can be contributed by other addons using the `backbone.registerLocalizedStrings` method. This collaborative approach allows developers to extend language support for plugins created by others, helping them reach a broader, more diverse audience. By fostering multilingual support, it enhances accessibility and usability, making plugins more inclusive and user-friendly across different languages and regions.

```lua
backbone.registerLocalizedStrings (
  'MyPlugin', 'deDE', {
    HELLO_WORLD = 'Hallo welt!',
    HELLO_WORLD2 = 'Hallo welt 2!',

    --[[ ... ]]
  }
)
```

> External translations are loaded after the addon's own translations, and will not overwrite any existing keys.

### Retrieving a localized string

To retrieve a localized string, use the `getLocalizedString` method with the string’s unique key.

```lua
print (plugin:getLocalizedString 'HELLO_WORLD')
```
> output: `Hello world!`

If the string is not available in the current locale, the method falls back to the `enUS` locale. If the string is also missing in the fallback locale, an error message is returned.

```lua
print (plugin:getLocalizedString 'MISSING_KEY')
```
> output: `The string "MISSING_KEY" is not registered for plugin "MyPlugin".`

## State management

State management is a core feature of the framework, providing tools to store and retrieve data across game sessions using saved variables. To enable this functionality, you must define the saved variable names in your addon's `.toc` file.

```toc
## SavedVariables: MyPluginAccountVariables
## SavedVariablesPerCharacter: MyPluginCharacterVariables
```

> Replace `MyPlugin` with the name of your addon. You can choose to enable account-wide variables, character-specific variables, or neither, depending on your requirements.

Attempting to access or modify a variable before the plugin is fully initialized will result in an error. To avoid this, ensure all state-dependent code is executed within an `onReady` callback (see [Initialization](#initialization)).

### Retrieving saved variables

Use the `getAccountVariable` or `getCharacterVariable` methods to retrieve the value of a saved variable. You can specify a single key or a slash-separated path to access nested data.

```lua
local accountVariable = plugin:getAccountVariable 'myVariable'
local characterVariable = plugin:getCharacterVariable 'myVariable'

local nestedAccountVariable = plugin:getAccountVariable 'topLevel/myNestedVariable'
local nestedCharacterVariable = plugin:getCharacterVariable 'topLevel/anotherLevel/myVariable'
```

### Setting the value of a saved variable

The `setAccountVariable` and `setCharacterVariable` methods allow you to update saved variables. Like retrieval, these methods support single keys and slash-separated paths.

```lua
plugin:setAccountVariable ('myVariable', true)
plugin:setCharacterVariable ('myVariable', true)

plugin:setAccountVariable ('topLevel/myNestedVariable', true)
plugin:setCharacterVariable ('topLevel/anotherLevel/myVariable', true)
```

> When setting nested variables, any missing intermediate tables will be created automatically.

## Plugin settings

The framework provides tools to manage plugin settings, enabling your addon to adapt dynamically to user preferences. This feature empowers players to customize how your addon behaves, enhancing its flexibility and delivering a more personalized user experience.

> Settings are persistently stored using saved variables, ensuring that user preferences are retained across game sessions for a seamless and consistent experience (see [State management](#state-management)).

### Registering default settings

To establish a baseline configuration for your addon, use the `registerDefaultSettings` method. This ensures default values are available, even if the user has not explicitly configured the settings. User-defined values will override these defaults when provided.

```lua
plugin:registerDefaultSettings {
  displayMode = 'compact',
  colorTheme = 'dark',
  
  --[[ add more settings as needed ... ]]
}
```

You can define nested settings for more organized and modular configuration. These can be accessed using a slash-separated path of keys, such as `frame/windowWidth`.

```lua
plugin:registerDefaultSettings {
  displayMode = 'compact',
  colorTheme = 'dark',
  
  --[[ add more settings as needed ... ]]
  
  frame = {
    windowWidth = 800,
    windowHeight = 600,
    
    --[[ add more frame settings as needed ... ]]
  }
}
```

### Retrieving the value of a setting

To access the current value of a setting, use the `getSetting` method. This method returns the user-defined value, if available, or the default value otherwise.

```lua
local displayMode = plugin:getSetting 'displayMode'
local windowWidth = plugin:getSetting 'frame/windowWidth'
```

> If the specified setting does not exist, an error will be thrown to ensure reliable access to valid keys.

### Changing the value of a setting

To update a setting dynamically, use the `setSetting` method. This saves the new value persistently, ensuring it is retained across sessions.

```lua
plugin:setSetting ('displayMode', 'expanded')
plugin:setSetting ('frame/windowWidth', 1200)
```

> If the value type does not match the default type, an error will be thrown to enforce type consistency and prevent misconfiguration.

## Services

A service is a component that provides functionality that is shared across multiple addons. Services allow you to centralize shared logic or data, making it easier to manage and maintain across different addons. The framework provides a simple and efficient way to implement services.

### Registering a service

?

```lua

```

> If your addon is a dedicated service, such as a data provider, use conditional loading to ensure it is only loaded when needed to optimize performance (see [Service requests](#service-requests)).

### Accessing a service

?

```lua

```

> When using the [Lua Language Server](https://luals.github.io/) — a highly recommended tool for development — the returned object's type is automatically inferred and assigned to match the service's name.

## Configuration - user interface integration

?

### Creating a configuration panel

?

```lua

```

## Conditional loading of addons

With its focus on performance, the framework includes support for and encourages the use of conditional loading of addons. This feature allows you to control when your addon should be loaded, optimizing memory usage and reducing the initial load time of the game, thus improving the overall user experience.

> To enable conditional loading, set the `LoadOnDemand` flag in the `.toc` file, and specify the conditions for when the addon should be loaded.

```
## LoadOnDemand: 1
```

### Game events

The `OnEvent` trigger is the simplest and most fundamental conditional loading mechanism. It enables you to define specific events that dictate when your addon should be loaded. By using this trigger, you can tailor your addon's behavior to respond dynamically to game events, ensuring it becomes active only when relevant conditions are met.

```
## X-Load-OnEvent: FIRST_EVENT [, SECOND_EVENT [, ...]]
```

### Loading of other addons

The `OnAddonLoaded` trigger allows you to designate another addon as the condition for loading your own addon. This is particularly useful when your addon relies on, extends, or enhances the functionality of another addon. By using this trigger, you can ensure that your addon only loads after the specified addon is fully loaded and operational.

```
## X-Load-OnAddonLoaded: SomeOtherAddon
```

### Service requests

If your addon is a dedicated service to other addons, such as a data provider or a database, you can use the `OnServiceRequest` trigger to ensure that it is loaded only when specifically requested.

```
## X-Load-OnServiceRequest: MyService
```

## Developer resources

?

## Reference documentation

These sections contain comprehensive details about the core components of the framework, including classes, functions, methods, and other essential elements. It is intended as a go-to resource for developers who need precise information about how to use and interact with the framework's features.

- [Framework API](docs/FRAMEWORK.md)

  Describes the methods and static resources provided by the framework.

- [Plugin methods](docs/PLUGIN.md)

  Details the lifecycle methods available for plugins.

- [Utility functions](docs/FUNCTIONS.md)

  Covers the reusable helper functions provided by the framework to simplify common tasks.

- [Class reference](docs/CLASSES.md)

  Describes the available classes, their methods, and intended usage.

- [Enumerations](docs/ENUMS.md)

  Lists the predefined enumerations and their associated values.