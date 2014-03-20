```
title: "FlxG"
```

```haxe
import flixel.FlxG;
```

This is a global helper class full of useful functions for audio, input, basic info, and the camera system among other things.

### FlxG.width
(**Int**) The width of the screen in game pixels.

### FlxG.height

(**Int**) The height of the screen in game pixels.

### FlxG.camera

(**FlxCamera**) Default camera. This just refers to the first entry in the cameras array.

### FlxG.elapsed

(**Float**) Represents the amount of time in seconds that passed since last frame, also known as "delta time".

### FlxG.timeScale

(**Float**) How fast or slow time should pass in the game; default is 1.0.

### FlxG.watch

Add a variable to the watch list in the debugger. This lets you to see and change the value of the variable at runtime.

``` haxe
FlxG.watch.add(object, "field");

// example
FlxG.watch.add(FlxG, "timeScale");
```

### FlxG.overlap()

Checks if a `FlxObject` overlaps another. Can be called with one `FlxObject` and one FlxGroup, or two `FlxGroup`, or two `FlxObject`, whatever floats your boat! For maximum performance try bundling a lot of objects together using a `FlxGroup` (or even bundling groups together!).

``` haxe
FlxG.overlap(object1, object2, callback);
```

### FlxG.collide()

This function just calls `FlxG.overlap()` and presets the `ProcessCallback` parameter to `FlxObject.separate()`.

``` haxe
FlxG.collide(object1, object2, callback);
```

### FlxG.fixedTimestep
(**Bool**)
* **True** (*default*): **Frame-based** animations.
* **False**: **Time-based** animations; results smoother animations at low FPS, but less physics accuracy. WARNING: Changing this may lead to issues with physics and the recording system.
