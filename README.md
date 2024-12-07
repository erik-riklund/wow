# Backbone
Version `1.0.0` (*work in progress*)
### A World of Warcraft addon development framework

---
## Table of contents

- [Introduction](#introduction)
- [Developer community](#developer-community)
- [Getting started and beyond](#getting-started-and-beyond)

## Introduction

Backbone is a framework designed to simplify the addon development process. Its toolkit allows you to focus on creating features, while the framework manages repetitive tasks and boilerplate code. Whether you are an experienced developer or new to addon development, Backbone provides a foundation for building robust and maintainable addons.

### Features

- ?

## Developer community

The Backbone community is a collaborative space built on respect and empowerment. Whether you are seeking help, sharing your latest project, or simply want to connect with others, the community is here to support you. Together, through collaboration and open communication, we can create a diverse and supportive environment where developers can learn, grow, and thrive.

> [Join the Backbone community on Discord](https://discord.gg/JaHq2wWweS) 💬

## Getting started and beyond

The `Plugin` class is a critical component of the Backbone framework, providing a set of features and tools for managing the lifecycle of a World of Warcraft addon. It is responsible for managing the addon's saved variables, providing access to configuration settings, acting as a central hub for managing events and channels, and more. By using the `Plugin` class, you can focus on creating features and functionality for your addon, while the framework handles the underlying plumbing.

```lua
-- The name of the plugin must match the name of the addon folder.
local plugin = backbone.createPlugin 'MyPlugin'
```

> All examples use the `plugin` variable to represent an active plugin.

---
### Initialization

The initialization process ensures that your plugin is fully set up and ready to use before executing any code. This is achieved through the `onReady` method, which guarantees that all necessary components — such as saved variables — are loaded and initialized. This step is crucial for features like the storage manager and configuration handler, as they rely on access to saved data to function correctly.

```lua
plugin:onReady(
  function ()
  -- The callback is executed when the plugin is fully initialized.
  end
)
```

The second example highlights the `backbone.onAddonReady` method, which allows you to execute a callback when another addon is fully loaded. This can be useful when your plugin interacts with or depends on another addon, ensuring that it is available before executing any related code:

```lua
backbone.onAddonReady(
  'SomeOtherAddon', function ()
    -- This callback will be executed when `SomeOtherAddon` is loaded.
  end
)
```

By leveraging these methods, you can ensure that your plugin and any dependencies are properly initialized, avoiding issues caused by missing or incomplete data during execution.

---
### Event handling

Event handling is a core feature of the framework, enabling your plugin to respond to game events dynamically. By registering listeners, you can define specific behaviors that are triggered when events occur, such as user actions or game state changes. This approach ensures that your plugin reacts seamlessly to the game's environment.

#### Registering an event listener

The `registerEventListener` method allows you to register a listener for a specific event. The following example demonstrates how to register a persistent event listener for `SOME_EVENT`. The callback function will be executed whenever the event is triggered:

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

- `callback` The function to execute when the event is triggered. This function can accept arguments specific to the event.
- `identifier?` A unique identifier for the listener. This is useful for debugging or selectively removing listeners.
  - If omitted, the listener will be anonymous (not eligible for targeted removal).
- `persistent?` Determines whether the listener remains active after being triggered.
  - If explicitly set to `false`, the listener will be removed after it is executed once.
  - If omitted, the listener will be persistent.

#### Removing an event listener

To remove an event listener, use the `removeEventListener` method. Specify the event name and the identifier of the listener you want to remove:

```lua
plugin:removeEventListener ('SOME_EVENT', 'MyEventListener')
```

This ensures that the listener is no longer active, which is useful when you need to manage resources or dynamically update the plugin's behavior based on changing game conditions.

---
### Framework channels

Framework channels are an important feature of Backbone, enabling both internal and inter-addon communication. Channels provide a structured way to invoke custom logic dynamically, either synchronously or asynchronously, based on your needs.

#### Creating a framework channel

The `createChannel` method is used to create a new channel. Channels can be configured to be either internal or public, and support both synchronous and asynchronous execution. Here's an example:

```lua
plugin:createChannel (
  'MY_CHANNEL', {
    internal = false, -- optional
    executeAsync = true -- optional
  }
)
```

- `internal?` Determines whether the channel is internal to the owning plugin.
  - If omitted, the channel is open to all plugins.
- `executeAsync?` Determines whether the channel listeners are executed asynchronously or synchronously.
  - If omitted, the channel listeners are executed asynchronously.

#### Registering a channel listener

You can register listeners to a channel using the `registerChannelListener` method. This allows you to define a callback function that is triggered whenever the channel is invoked:

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

- `callback` The function to execute when the channel is invoked.
  - The callback should accept arguments specific to the channel.
- `identifier?` A unique identifier for the listener.
  - This is useful for debugging and required for targeted removal.
  - If omitted, the listener will be anonymous (not eligible for targeted removal).
- `persistent?` Determines whether the listener remains active after being invoked.
  - If explicitly set to `false`, the listener will be removed after it is executed once.
  - If omitted, the listener will be persistent.

#### Removing a channel listener

To remove a listener from a channel, use the `removeChannelListener` method. Specify the channel name and the identifier of the listener to be removed:

```lua
plugin:removeChanneListener ('MY_CHANNEL', 'MyChannelListener')
```

This ensures that the listener is no longer active, which is helpful when you need to dynamically manage the behavior of your plugin in response to changing game conditions.

#### Invoking channel listeners

The `invokeChannelListeners` method is used to trigger all listeners registered to a specific channel. You can pass any number of arguments to the listeners during invocation:

```lua
plugin:invokeChannelListeners ('MY_CHANNEL', --[[ channel-specific arguments ]])
```

> If the channel is meant for communication with other addons, it is important to clearly document the arguments that is passed to the channel listeners.

---
### Localization

Localization is the process of translating text into different languages to make content accessible to a broader audience. The framework includes tools for managing localized strings, enabling you to define and retrieve text in multiple languages with ease.

#### Registering localized strings

The `registerLocalizedStrings` method enables you to register localized strings for a specific language. You can add strings to the same locale multiple times, but each set of strings must have unique keys. If key collisions occur, the existing strings will not be overwritten.

```lua
plugin:registerLocalizedStrings (
  'enUS', {
    HELLO_WORLD = 'Hello world!',
    HELLO_WORLD2 = 'Hello world 2!',
    
    --[[ ... ]]
  }
)
```

> The `enUS` locale is the default locale for the framework.

#### Adding external translations

Translations for strings can be added by external addons using the `backbone.registerLocalizedStrings` method. This approach allows addons to contribute translations for various languages to other plugins, enhancing the overall localization process while fostering a collaborative ecosystem.

```lua
backbone.registerLocalizedStrings (
  'MyPlugin', 'deDE', {
    HELLO_WORLD = 'Hallo welt!',
    HELLO_WORLD2 = 'Hallo welt 2!',

    --[[ ... ]]
  }
)
```

> Strings from external sources are loaded last to ensure that keys registered by the plugin itself take priority.

#### Retrieving a localized string

The `getLocalizedString` method allows you to retrieve a localized string based on its key.

```lua
print (plugin:getLocalizedString 'HELLO_WORLD')
```
> output: `Hello world!`

If the string is not defined for the active locale, the method will fall back to the `enUS` locale. If the string is also missing in the fallback locale, the method will return an error message.

```lua
print (plugin:getLocalizedString 'HELLO_WORLD3')
```
> output: `The string "HELLO_WORLD3" is not registered for plugin "MyPlugin".`

---
### State management

The framework provides tools for managing state, allowing you to store and retrieve data across game sessions using saved variables. To enable this feature, you need to include the variable definitions in the `.toc` file, as shown in the example below:

```toc
## SavedVariables: MyPluginAccountVariables
## SavedVariablesPerCharacter: MyPluginCharacterVariables
```

> Replace `MyPlugin` with the name of your addon. You can choose to enable account-wide variables, character-specific variables, or neither, depending on your requirements.

#### Retrieving saved variables

?

#### Setting the value of a saved variable

?

---
### Plugin configuration

?

---
### ?

?