```
title: "iOS"
```

<img src="/images/targets/ios-logo.svg" width="160px" style="float:left; padding:10px" />

The iOS target makes use of a chain of frameworks to compile your native iOS game from Haxe code. OpenFL uses the [Hxcpp](http://lib.haxe.org/p/hxcpp) and XCode natively so no virtual machine is involved.
When you compile an iOS project an xcode project file is also automatically generated in the build directly so you can make use of the XCode profiler and toolset.

The Haxe compiler uses it's ```cpp``` target to compile your ```Haxe``` code for the [LibSDL](http://libsdl.org) OpenGL library.
iOS is is part of the cpp group of targets so when developers mention ```cpp``` the topic will may be relevant to HaxeFlixel iOS.

With [OpenFL](http://openfl.org) using native-code and OpenGL with [LibSDL](http://libsdl.org), the rendering methods are different to where Flixel started with Flash.
iOS uses GPU accelerated Texture Batching for the best possible performance in mobile devices.

### Conditionals
----

```
#if cpp
//your iOS code
#end

#if ios
//your iOS code
#end

#if mobile
//your iOS code
#end
```

### Project XML settings
----

Mobile platforms can use a window width and height of 0, which is a special value that uses the full resolution of the current display.

```
<window width="0" height="0" background="#FFFFFF" fps="60" />
```

OpenFL also exposes the following specific settings for the Android target:

```
<window hardware="true" allow-shaders="true" require-shaders="true" if="cpp"/>
<window vsync="true" antialiasing="4" if="cpp" />
<window orientation="portrait" /> || <window orientation="landscape" if="cpp"/>
```

### Compile Commands
----

Sublime Text, Flash Develop and Intellij Idea support Android compilation through their GUI.

#### Command line
----

The basic command to compile and test iOS:

```
lime test ios
```

Run this command from the root folder of your project, the default project.xml will be used automatically.

----

If you want to use the IOS emulator, add “-simulator when running/testing.

```
lime test ios -simulator
```

----