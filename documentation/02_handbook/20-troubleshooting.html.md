```
title: "Troubleshooting"
```
Unexpected behaviour one one may find with sources that are hard to determine.

## Framerate inconsistency in an empty FlxState in Flash's Debugger

A possible cause for this is related to input handling. To fix, you may want to disable any inputs you don't use at compile time.
The library offers some compiler parameters for this, which can be passed by adding any of the following lines to your [Project.XML](documentation/openfl-project-xml-format/) file:

``` xml
<haxedef name="FLX_NO_MOUSE" />
<haxedef name="FLX_NO_KEYBOARD" />
<haxedef name="FLX_NO_TOUCH"/>
<haxedef name="FLX_NO_GAMEPAD" />
```

## Undesired stretching when window size varies

Assigning a new instance of any of the classes that inherit from BaseScaleMode to FlxG.scalemode will set this to the desired scaling. However these settings may override the zoom value set when instancing a FlxGame.
