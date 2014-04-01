```
title: "HaxeFlixel Conditionals"
```

### What is "conditional compilation"?

[Conditional compilation macros](http://haxe.org/ref/conditionals) are a powerful feature Haxe offers to optimize your code by only compiling certain parts of it. For example, the following pseudo-code optimizes inputs based on the target platform:

``` haxe
#if (web || desktop)
keyboardControls();
mouseControls();
#end

#if desktop
gamepadControls();
#end

#if mobile
touchControls();
#end
```

Basically, this means that for web or desktop targets, we want to have mouse and keyboard controls. In case of a mobile target, we want touch input. Like you can see, these so-called defines can also be nested: We only  want gamepad controls to be available on non-web targets (line 4). So, all in all, these defines can be used largely like traditional if-statements, except their syntax varies slightly.

For more information on what defines are available, by default check out the [OpenFL documentation](http://www.openfl.org/archive/developer/documentation/conditional-compilation/) on this topic.

### HaxeFlixel specific defines

If you had a look at the OpenFL documentation, you might have found out that you can also set your own defines. When working with OpenFL, it's convenient to do so in the Project XML file.
HaxeFlixel makes use of this feature and allows you to optimize your game using the following defines (a list of them can also be found in the [template](https://github.com/HaxeFlixel/flixel-templates/blob/master/default/Project.xml.tpl)):

```
// Example xml node to enable to Flixel record system.

<haxedef name="FLX_RECORD" />

```

#### FLX_RECORD

Flixel features a powerful recording / playback feature which captures mouse and keyboard input. Since it's used rarely, we decided that it makes sense to turn it off by default. Setting this define however will enable it again.

#### FLX_MOUSE_ADVANCED

This define is required for middle and right mouse button input. On the flash target, a minimum flash player version of 11.2 is required. Listening to right click input will also disable the right-click menu of the flash player. There is currently no HTML5 support for this feature.

#### FLX_NO_NATIVE_CURSOR

By default, flixel uses the flash [native cursor API](http://www.adobe.com/devnet/flashplayer/articles/native-mouse-cursors.html). This gets rid of the almost unbearable mouse lag that is unavoidable otherwise. This define allows you to disable that - reasons for this might be that you want to target a flash player version older than 10.2 or that you need to use a cursor bigger than 32x32, which is not possible using the native cursor API.

#### FLX_NO_MOUSE

This allows you to optimize your game by compiling it without any mouse-related code, which can make sense for mobile targets. This is why in the template, if="mobile"  is added to the haxedef set tag. Keep in mind that this might require you to use conditionals in your own code for anything related to FlxG.mouse, which does not exist if this define is set.

#### FLX_NO_KEYBOARD

This allows you to optimize your game by compiling it without any keyboard-related code, which can make sense for mobile targets. This is why in the template, if="mobile"  is added to the haxedef set tag. Keep in mind that this might require you to use conditionals in your own code for anything related to FlxG.keyboard or FlxG.keys, which do not exist if this define is set.

#### FLX_NO_TOUCH

This allows you to optimize your game by compiling it without any touch-related code, which can make sense for desktop targets. This is why in the template, if="desktop"  is added to the haxedef set tag. Keep in mind that this might require you to use conditionals in your own code for anything related to FlxG.touches, which does not exist if this define is set.

#### FLX_NO_GAMEPAD

This allows you to optimize your game by compiling it without any gamepad-related code. Keep in mind that this might require you to use conditionals in your own code for anything related to FlxG.gamepads, which does not exist if this define is set.

#### FLX_NO_SOUNDTRAY

This disables the flixel core sound tray, which appears whenever your adjust the volume via the 0 (mute the game), + or - keys. Note that this does not disable the ability to control the game's volume using these hotkeys, just the soundtray itself. You can disable volume control entirely by setting FlxG.sound.muteKeys, FlxG.sound.volumeUpKeys and FlxG.sound.volumeDownKeys to null.

#### FLX_NO_FOCUS_LOST_SCREEN

Flixel automatically pauses the game when it loses focus and shows its so-called "focus lost screen", which is basically an overlay darkening the screen area with a white "play-button" in the middle. Using this define disables that screen, but not the feature to automatically pause - use the FlxG.autoPause Bool for that.

#### FLX_NO_DEBUG

This disables the flixel core debugger, which you can toggle using the \ and ` keys. It makes sense to do so for release build, which is why unless="debug"  is added to this tag in the template. It basically means that the flixel debugger is disabled when compiling a release, and enabled when compiling a debug build.
