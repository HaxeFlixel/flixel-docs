```
title: "Compiler Conditionals"
```

The Haxe compiler provides a robust solution for cross-platform development where you can use operators to define what targets receive your code. This functionality is invaluable for HaxeFlixel since we are targeting native mobile / desktop and web targets, all with different capabilities.

[Official Conditional Compilation documentation](http://haxe.org/ref/conditionals)

A basic example may include logic like this:

``` haxe
#if desktop

// desktop only code

#elseif mobile

// mobile only code

#end
```
Conditionals relevant to your HaxeFlixel games may include:

```
mobile, desktop, native, web
ios, android, blackberry, webos, windows, mac, linux, html5
flash, cpp, neko, js
```
Multiple targets can be used together:


```
#if (mac || linux || android)

// code specific for these platforms

#end
```

To define your own it is as easy as adding to your ```Project.xml```:

```
<set name="magic" />
```

Now this will work:

```
#if magic
//Create a dragon
#end
```

Since Haxe lets you use some logic with the conditionals you can enable something just for mobile, as in:

```
<set name="magic" if="mobile"/>
```
