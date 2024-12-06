# Backbone
Version `1.0.0` (*work in progress*)
### A World of Warcraft addon development framework

Backbone is a powerful World of Warcraft addon framework that makes building addons easier and more efficient. With its intuitive toolkit, developers can focus on creating unique features while the framework handles repetitive tasks and boilerplate code. Whether you are an experienced developer or just getting started, Backbone provides a solid foundation for crafting high-quality addons.

## Table of contents

1. [Introduction](#1-introduction)
    - [Features](#features)
    - [Developer community](#developer-community)
2. [Usage examples](#2-usage-examples)

## 1. Introduction

?

### Features

- ?

### Developer community

The Backbone community is a collaborative space built on respect and empowerment. Whether you are seeking help, sharing your latest project, or simply want to connect with others, the community is here to support you. Together, through collaboration and open communication, we can create a vibrant and supportive environment where developers can learn, grow, and thrive.

> [Join the Backbone community on Discord](https://discord.gg/JaHq2wWweS)

## 2. Usage examples

The examples in this section use the `plugin` variable to represent an active plugin.

```lua
-- The name of the plugin must match the name of the addon folder.
local plugin = backbone.createPlugin 'MyPlugin'
```

One of the most common tasks in addon development is initialization. The example below demonstrates how to properly initialize a plugin:

```lua
plugin:onReady(
  function()
  -- When this callback is executed, everything has been loaded;
  -- saved variables are available, and the plugin is ready to use.
  end
)
```

?