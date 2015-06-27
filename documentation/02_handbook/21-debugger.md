```
title: "Debugger"
```

Flixel comes with a fairly powerful debugging overlay. You can open it with one of the two default toggle keys (\` and \, on a QWERTY keyboard layout at least). Note that these are configurable via `FlxG.debugger.toggleKeys`. Alternatively, you can do the same in code via the `FlxG.debugger.visible` flag.

Note that the debugger does not exist when compiling with `FLX_NO_DEBUG`. With the default `Project.xml`, this is the case in release mode.

![](../images/02_handbook/debugger/debugger-overlay.png)

## Debug draw

`FlxG.debugger.drawDebug` can be enabled to display the hitboxes of every `FlxObject` added to the state (alternatively, press the cube button in the upper right corner of the debugger).

![](../images/02_handbook/debugger/draw-debug.png)

The hitboxes are color-coded based on the collision properties. For `FlxObject` and `FlxSprite` this means:

- Blue for `allowCollisions == FlxObject.NONE`
- Green for `immovable` objects
- Red otherwise

The color is customizable via the `debugBoundingBoxColor` property.

The behavior of tiles in `FlxTilemap` is slightly different:

- Blue for `allowCollisions == FlxObject.NONE`
- Green for `allowCollisions == FlxObject.ANY`
- Pink for other values of `allowCollisions`

## The Log Window

The log window is used to display traces and can be accessed via `FlxG.log`. You can also redirect any `trace()`-calls to it with `FlxG.log.redirectTraces = true;`. Using it is mostly a matter of preference, some people prefer to have their traces displayed in their IDE of choice (FlashDevelop's output panel for example).

Some flixel-internal errors will also be output to the log window.

### Log styles

It's possible to customize things like text color, size, style or add a prefix by using log styles. `FlxG.log.warn()`, `error()` and `notice()` use pre-defined log styles.

Here's an example of how you could differentiate each trace by the player from others by adding a `[Player]` prefix and printing it in green:

```haxe
var playerAction = new LogStyle("[Player]", "00FF40");
FlxG.log.advanced(" Shoot", playerAction);
```

## The Watch Window

It's very common to use `trace()`-calls to output the value of certain variables for debugging. However, this approach doesn't scale very well - at 60 fps, tracing the values of multiple variables results in a flood of messages. Breakpoints-debugging is great to inspect a game's internal state, but doesn't help when interrupting the execution is not an option, for example when debugging input logic.

This is where the watch window comes into play. It displays the values of variables using reflection. For example, to keep track of the player's position:

```haxe
FlxG.watch.add(_player, "x");
FlxG.watch.add(_player, "y");
```

The display string does not have to be the same as the variable's name, "numEnemies" is much more descriptive than "length" in this example:

```haxe
FlxG.watch.add(_enemies, "length", "numEnemies");
```

![](../images/02_handbook/debugger/watch-window.png)

For static variables, you pass the class instead of an object:

```haxe
FlxG.watch.add(FlxG, "height");
```

It's also possible to edit the displayed values by clicking on them, entering a new value in the text field and pressing enter to confirm. This even works with `FlxPoint` objects.

To remove a watch entry again, simply call `FlxG.watch.remove(object, variableName)`.

### Quick watches

Quick watches are a lightweight alternative to a regular watch entry. They don't require a variable, they simply store a value for a `String` name. The following example stores the result of `FlxG.keys.anyPressed(["UP", "W"])` under the name `"Up key pressed"` - this is updated every frame since it happens in `update()`.

```haxe
override public function update():Void
{
	super.update();
	FlxG.watch.addQuick("Up key pressed", FlxG.keys.anyPressed(["UP", "W"]));
}
```

To remove a quick watch entry, call `FlxG.watch.removeQuick(name)`.
Quick watch values can not be modified.

### Mouse watch

`FlxG.watch.addMouse()` is a convenient helper to display the current mouse position in the watch window. This can be useful to find the right coordinates to position UI elements at. You can also use the console command `watchMouse` (short: `wm`) to call this function.

## The Stats Window

The stats window displays some basic profiling info:

1. FPS value
2. Memory usage in MB
3. The amount of `update()` calls this frame (and the time it took in ms)
4. The amount of `draw()` calls this frame (and the time it took in ms)
5. The size of the `FlxQuadtree` pool for collision detection
6. The size of the `FlxList` (used for quad trees) pool

3 and 4 are especially useful when it comes to performance optimization ("Do I need to optimize my rendering or my update-logic?"). Of course this is only very basic data, profiling tools like [Adobe Scout](https://creative.adobe.com/products/scout) or [hxScout](https://github.com/jcward/hxScout) provide much more detailed information.

![](../images/02_handbook/debugger/stats-window.png)

## The Bitmap Log Window

The Bitmap Log can be used to display `BitmapData` objects via `FlxG.bitmapLog.add(bitmapData)`. This can be useful to debug logic that manipulates some `BitmapData`. The window provides a slideshow to scroll through logged bitmaps. You can use the middle mouse button to move the graphic around and the mouse wheel to zoom in and out.

You can also inspect flixel's internal `BitmapData` cache by calling `FlxG.bitmapLog.viewCache()` or entering the console command `viewCache` (short: `vc`).

![](../images/02_handbook/debugger/view-cache.png)

## The Console Window

The console allows you to do things like calling arbitrary functions or setting the values of arbitrary variables at runtime (where you would otherwise have to recompile the game).

By default, the game is paused when the console text field receives focus. After a command is executed, the game progresses one frame so the effects can be seen.

The console stores executed commands (use the up and down keys to cycle through them). This history is persistent across executions of your game (but not across different target platforms).

The `help` command already provides a short documentation on available commands, for some however it's worth going into a little more detail.

### The `set` command

`set` (short: `s`) sets the value of an arbitrary variable using `Reflect.setProperty()`.

Let's take a look at an example that works in the Mode demo:

```
set FlxG.state._player.x 50
```

If the command was successful, the player x position should now be 50 and the log window says `> set: Player.x is now 50`.

The first argument is the path to the variable. The "starting point" of the dot-path needs to be registered for the console to be able to resolve the variable. `FlxG` is automatically registered to the console beforehand by Flixel.
The same is true for the current `FlxG.state` instance. This allows us to shorten the command:

```
set state._player.x 50`
```

To register objects (to access member variables) or classes (to access static variables), you can call `FlxG.console.registerObject()`:

```haxe
// Inside the Player constructor
FlxG.console.registerObject("player", this);
```

With that, the previous command can be shortened even further to just `set player.x 50`.

### The `call` command

`call` (short: `c`) is the counterpart to `set` for calling function (using `Reflect.callMethod()` under the hood). We can use this to make the Player in Mode jump:

```
call state._player.jump
```

Upon succesful execution, `> call: Called 'state._player.jump()'` should be output to the log window.
`FlxG.console.registerFunction()` can be used to register a function with an alias. This can be used to shorten the previous command to just `call jump`:

```haxe
// Inside the Player constructor
FlxG.console.registerFunction("jump", jump);
```

You can also call functions with arguments:

```
call FlxG.camera.shake 0.05 5
```

## Tracker Windows

## The VCR

## Extending the Debugger



## Debugger Styles
