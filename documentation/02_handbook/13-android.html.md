```
title: "Android"
```

<img src="/images/targets/android-logo.svg" width="160px" style="float:left; padding:10px" />

The Android target makes use of a chain of frameworks to compile your native Android game from Haxe code. OpenFL uses the [Hxcpp](http://lib.haxe.org/p/hxcpp) and the [Android NDK](http://developer.android.com/tools/sdk/ndk/index.html) specifically so no virtual machine is involved.

The Haxe compiler uses it's ```cpp``` target to compile your ```Haxe``` code for the [LibSDL](http://libsdl.org) OpenGL library so that the Android NDK can then use this "native-code" for your Android game. You can read more about the Android NDK from Google [here](http://developer.android.com/tools/sdk/ndk/index.html), however this process is completely automated by [OpenFL](http://openfl.org). Android is is part of the cpp group of targets and when developers mention ```cpp``` the topic will may be relevant to HaxeFlixel Android.

With [OpenFL](http://openfl.org) using native-code and OpenGL with [LibSDL](http://libsdl.org), the rendering methods are different to where Flixel started with Flash. Android uses GPU accelerated Texture Batching for the best possible performance in mobile devices.

### Conditionals
----

```
#if cpp
//your android code
#end

#if android
//your android code
#end

#if mobile
//your android code
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

The basic command to compile and test Android:

```
lime test android
```

Run this command from the root folder of your project, the default project.xml will be used automatically. For the test command to run on your device you should have it connected with ADB working correctly.

----

If you want to use the Android simulator, add “-simulator when running/testing. Be sure your virtual device is API >=15 and has GPU enabled.

```
lime test android -simulator
```

----