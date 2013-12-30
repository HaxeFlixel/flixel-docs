```
title: "FlxG"
```

This is a global helper class full of useful functions for audio, input, basic info, and the camera system among other things.

#### FlxG.width

The width of the screen in game pixels.

#### FlxG.height

The height of the screen in game pixels.

#### FlxG.camera

By default this just refers to the first entry in the cameras array.

#### FlxG.elapsed

Represents the amount of time in seconds that passed since last frame.

#### FlxG.timeScale

How fast or slow time should pass in the game; default is 1.0.

#### FlxG.log()

Log data to the debugger.

``` haxe
FlxG.log("String", myVariable, "1", "2", "3");
```


#### FlxG.watch()

Add a variable to the watch list in the debugger. This lets you see the value of the variable all the time.

``` haxe
FlxG.watch(object, "field");
```


#### FlxG.overlap()

Checks if a FlxObject overlaps another. Can be called with one FlxObject and one FlxGroup, or two FlxGroup, or two FlxObject, whatever floats your boat! For maximum performance try bundling a lot of objects together using a FlxGroup (or even bundling groups together!).

``` haxe
FlxG.overlap(object1, object2, callback);
```


#### FlxG.collide()

This function just calls FlxG.overlap() and presets the ProcessCallback parameter to FlxObject.separate.

``` haxe
FlxG.collide(object1, object2, callback);
```
