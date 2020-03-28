```
title: "Troubleshooting"
```
Unexpected behaviour one one may find with sources that are hard to determine.

## Timestep

By default the library performs calculations with a fixed timestep, to change this set `FlxG.fixedTimestep = false`

#### Explanation of timesteps

If you are unfamiliar with timesteps, here is a quick explanation.

A fixed timestep results in `FlxG.elapsed` always returning the same value in each update() iteration. The result is that the game runs "slower" if the computer can't keep up with the update speed. So for example, if the game is supposed to run at 60 FPS and it's running at 30 FPS, the user will perceive it to run at half the expected speed.

A variable timestep results in `FlxG.elapsed` returning a value according to the time that passed since the last update() call, and the game running at perceivably the expected speed for the user. However if the framerate is too low and the coder hasn't been careful (or studied Numerical Analysis), it could result in unpredicted behaviour and a game that doesn't run slow but is simply unplayable or broken.

## Framerate inconsistency in an empty FlxState

A possible cause for this is related to input handling. To fix, you may want to disable any inputs you don't use in your target platforms at compile time.
The library offers some conditional compilation flags for this:
* FLX_NO_MOUSE
* FLX_NO_KEYBOARD
* FLX_NO_TOUCH
* FLX_NO_GAMEPAD

These can be passed as parameters preceded by `-D` if compiling via command line (for example `-D FLX_NO_MOUSE`), or passed by adding them to your [Project.XML](documentation/openfl-project-xml-format/) file if you have one. For example, someone who is publishing to multiple platforms could have:

``` xml
<haxedef name="FLX_NO_MOUSE" if="mobile" />
<haxedef name="FLX_NO_KEYBOARD" />
<haxedef name="FLX_NO_TOUCH" if="desktop"/>
<haxedef name="FLX_NO_GAMEPAD" if="web"/>
```
If you created your [Project.XML](documentation/openfl-project-xml-format/) from a template, these options are most likely already in the file but commented out.

## Undesired stretching when window size varies

Assigning a new instance of any of the classes that inherit from [BaseScaleMode](http://haxeflixel.github.io/flixel-docs/flixel/system/scaleModes/BaseScaleMode.html) to `FlxG.scalemode` will set this to the desired scaling. However these settings may override the zoom value set when instancing a `FlxGame`.
