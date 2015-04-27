```
title: "Debugger"
```

Flixel comes with a fairly powerful debugging overlay. You can open it with one of the two default toggle keys (` and \, on a QWERTY keyboard layout at least). Note that these are configurable via `FlxG.debugger.toggleKeys`. Alternatively, you can do the same in code via the `FlxG.debugger.visible` flag.

Note that the debugger does not exist if you compile your game with the `FLX_NO_DEBUG` define, which with the default Project.xml file happens whenever you compile in release mode.

# PICTURE

## Debug draw

`FlxG.debugger.drawDebug` can be enabled to display the hitboxes of `FlxObject`s (alternatively, press the cube button in the upper right corner of the debugger).

# PICTURE

The hitboxes are color-coded based the collision properties. For `FlxObject` and `FlxSprite` this means:

- Blue for `allowCollisions == FlxObject.NONE`
- Green for `immovable` objects
- Red otherwise

The color is customizable via the `debugBoundingBoxColor` property.

The behavior of tiles in `FlxTilemap` is slightly different:

- Blue for `allowCollisions == FlxObject.NONE`
- Green for `allowCollisions == FlxObject.ANY`
- Pink for other values of `allowCollisions`

## The Log Window

The log window can be used to display traces and can be accessed via `FlxG.log`. You can also redirect any `trace()` calls to it with `FlxG.log.redirectTraces = true;`. Using it is mostly a matter of preference, some people prefer to have their traces displayed in their IDE of choice (FlashDevelop's output panel, for example).

Some flixel-internal errors will also be output to the log window.

### Log styles

It's possible to customize things like text color, size, style or add a prefix by using log styles. `FlxG.log.warn()`, `error()` and `notice()` use pre-defined log styles.

Here's an example of how you could differentiate each trace by the player from others by adding a `[Player]` prefix and printing it in green:

```haxe
var playerAction = new LogStyle("[Player]", "00FF40");
FlxG.log.advanced(" Shoot", playerAction);
```

## The Watch Window

Using traces to keep track of game internal state is often not very convenient, especially when you want to do so with several different variables that are logged every frame - at 60 FPS, that's 60 traces per frame per variable. Breakpoint-debugging is great for this, but sadly this is currently only possible on some targets (Flash and hxcpp, though the latter is still experimtenal). Besides, often times you don't want to interrupt the game's execution.

This is where the watch window comes into play. It displays the values of variables using Reflection (which means it needs a reference to the object the variable belongs to and the variable's name). For example, to keep track of the player's position:

```haxe
FlxG.watch.add(_player, "x");
FlxG.watch.add(_player, "y");
```

The display string does not have to be the same as the variable's name, "numEnemies" is much more descriptive than "length" in this example:

```haxe
FlxG.watch.add(_enemies, "length", "numEnemies");
```

For static variables, you pass the class instead of an object:

```
FlxG.watch.add(FlxG, "height");
```

Additionally to just displaying variable values, you can also modify them! Simply click on the value, enter a new value and press enter to do so. This even works with `FlxPoint` objects.

To remove a watch entry again, simply call `FlxG.watch.remove(object, variableName)`.

### Quick watches

Quick watches are a nice alternative to `trace()` calls in `update()`-logic which would quickly flood your log window. They don't require a variable like a regular watch, they simply store a value to a string ID, "Up key pressed" in this case:

```
override public function update():Void
{
	super.update();
	FlxG.watch.addQuick("Up key pressed", FlxG.keys.anyPressed(["Up", "W"]));
}
```

Quick watch values can not be modified.


### Mouse watch

`FlxG.watch.addMouse()` is a convenient helper to display the mouse position - it's especially useful for figuring out right positioning of UI elements. You can also use the console command `watchMouse` (short: `wm`) to call this function.

## The Stats Window

The stats window displays some basic profiling info:

# PICTURE

1. FPS value
2. Memory usage in MB
3. The amount of `update()` calls this frame (and the time it took in ms)
4. The amount of `draw()` calls this frame (and the time it took in ms)
5. The size of the `FlxQuadtree` pool for collision detection
6. The size of the `FlxList` (used for quad trees) pool

3 and 4 are especially useful when it comes to performance optimization ("Do I need to focus on rendering or update-logic?"). Of course this is only very basic data, profiling tools like [Adobe Scout](https://creative.adobe.com/products/scout) provide much more detailed information.

## The Bitmap Log Window

The Bitmap Log can be used to display `BitmapData` (`FlxG.bitmapLog.add()`). This is especially useful to debug bitmap data manipulation / rendering. The window provides a slideshow to scroll through logged bitmaps. You can use the middle mouse button to move the bitmap around and the mouse wheel to zoom in and out.

# PICTURE

You can also take a peek at flixel's internal `BitmapData` cache by calling `FlxG.bitmapLog.viewCache()` or entering the console command `viewCache` (short: `vc`).

## The Console Window

The console allows you to do things like calling arbitrary functions or setting the values of arbitrary variables at runtime (where you would otherwise have to recompile the game).

By default, the game is paused when the console textfield receives focus. After a command is executed, the game progresses one frame so the effects can be seen.

The console stores executed commands (use the up and down keys to cycle through them). This history is persistent across executions of your game (but not across different target platforms).

The `help` command already provides a short documentation on available commands, for some however it's worth going into a little more detail.

### The set command

`set` (short: `s`) sets the value of an arbitrary variable using `Reflect.setProperty()`.

Let's take a look at an example that works in the Mode demo:

`set FlxG.state._player.x 50`

If the command was successful, the player x position should now be 50 and the log window says `> set: Player.x is now 50`.

The path to the variable is like you'd expect from Haxe source code, the second argument is the desired value. Note that we can only access `FlxG` because it's been registered to the console beforehand by Flixel. The current `FlxG.state` object is also registered as `state`, which means we can also write the command a bit shorter:

`set state._player.x 50`

To register objects (to access member variables) and classes (to access static variables), you can call `FlxG.console.registerObject()`:

```

```

## Tracker Windows

## The VCR

## Extending the Debugger

## Debugger Styles