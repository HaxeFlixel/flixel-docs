---
title: "Compiler Conditionals"
---
The Haxe compiler provides a robust solution for cross-platform development where you can use operators to define what targets receive your code. This functionality is invaluable for HaxeFlixel since we are targeting native mobile / desktop and web targets, all with different capabilities.

[Conditional Compilation in the Haxe Manual](https://haxe.org/manual/lf-condition-compilation.html)

A basic example may include logic like this:

``` haxe
#if desktop

// desktop only code

#elseif mobile

// mobile only code

#end
```
Conditionals relevant to your HaxeFlixel games may include:

- `mobile`, `desktop`, `web`
- `ios`, `android`, `windows`, `mac`, `linux`, `html5`
- `flash`, `cpp`, `neko`, `js`

Multiple targets can be used together:


```haxe
#if (mac || linux || android)

// code specific for these platforms

#end
```

To define your own it is as easy as adding to your ```Project.xml```:

```xml
<haxedef name="magic" />
```

Now this will work:

```haxe
#if magic
// Create a dragon
#end
```

Since Haxe lets you use some logic with the conditionals you can enable something just for mobile, as in:

```xml
<haxedef name="magic" if="mobile"/>
```
