```
title: "Troubleshooting"
```
Unexpected behaviour one one may find with sources that are hard to determine.

## Framerate inconsistency in an empty FlxState

A possible cause for this is related to input handling. To fix, you may want to disable any inputs you don't use in your target platforms at compile time.
The library offers some compiler definitions for this:
* FLX_NO_MOUSE
* FLX_NO_KEYBOARD
* FLX_NO_TOUCH
* FLX_NO_GAMEPAD

These can be passed normally, or passed by adding them to your [Project.XML](documentation/openfl-project-xml-format/) file if you have one. For example, someone who is publishing to multiple platforms could have:

``` xml
<haxedef name="FLX_NO_MOUSE" if="mobile" />
<haxedef name="FLX_NO_KEYBOARD" />
<haxedef name="FLX_NO_TOUCH" if="desktop"/>
<haxedef name="FLX_NO_GAMEPAD" if="web"/>
```
If you created your [Project.XML](documentation/openfl-project-xml-format/) from a template, these options are most likely already in the file but commented out.

## Undesired stretching when window size varies

Assigning a new instance of any of the classes that inherit from [BaseScaleMode](http://api.haxeflixel.com/types/flixel/system/scaleModes/BaseScaleMode.html) to `FlxG.scalemode` will set this to the desired scaling. However these settings may override the zoom value set when instancing a `FlxGame`.
