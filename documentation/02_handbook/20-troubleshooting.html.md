```
title: "Troubleshooting"
```
Unexpected behaviour one one may find with sources that are hard to determine.

## Framerate inconsistency in an empty FlxState in Flash's Debugger

A possible cause for this is related to input handling. To fix, you may want to disable any inputs you don't use at compile time.
Haxe offers a [compilation flag](http://haxe.org/manual/tips_and_tricks) that can do just this, and OpenFL can pass this to the compiler by adding any of the following lines to your [Project.XML](documentation/openfl-project-xml-format/) file:

``` xml
<haxedef name="FLX_NO_MOUSE" />
<haxedef name="FLX_NO_KEYBOARD" />
<haxedef name="FLX_NO_TOUCH"/>
<haxedef name="FLX_NO_GAMEPAD" />
```

## Undesired stretching on variable window size varies

Assigning a new instance of any of the classes that inherit from [BaseScaleMode](http://api.haxeflixel.com/types/flixel/system/scaleModes/BaseScaleMode.html) to FlxG.scalemode will set this to the desired scaling. However these settings may override the "zoom calculation" when instancing a FlxGame.
