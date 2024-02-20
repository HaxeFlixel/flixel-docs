---
title: "Mouse"
apiPath: input/mouse/FlxMouse.html
---

Mouse input for HaxeFlixel is provided through the `FlxMouse` class and is available through `FlxG.mouse`. It is worth noting that it extends `FlxPoint`.

On non-mobile targets, the mouse starts out by being visible by default. You can set the visibility via `FlxG.mouse.visible`.

## Left mouse button

The most common use of `FlxG.mouse` is checking the state of the left mouse button.

``` haxe
override public function update(elapsed:Float):Void
{
	if (FlxG.mouse.pressed)
	{
		// The left mouse button is currently pressed
	}
	
	if (FlxG.mouse.justPressed)
	{
		// The left mouse button has just been pressed
	}
	
	if (FlxG.mouse.justReleased)
	{
		// The left mouse button has just been released
	}

	super.update(elapsed);
}

```

Exactly the same logic can be used for the middle and right mouse buttons. The properties are postfixed by `Middle` / `Right`, e.g. `FlxG.mouse.pressedRight`.

## Cursor

```haxe
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

// Create a white circle to use as a cursor graphic
var sprite = new FlxSprite();
sprite.makeGraphic(15, 15, FlxColor.TRANSPARENT);
sprite.drawCircle();

// Load the sprite's graphic to the cursor
FlxG.mouse.load(sprite.pixels);

// Use the default mouse cursor again
FlxG.mouse.unload();

// To use the system cursor:
FlxG.mouse.useSystemCursor = true;
```

## Positional data

There are two kinds of position data available:

* #### World position (absolute)
	
	```haxe
	FlxG.mouse.x
	FlxG.mouse.y
	FlxG.mouse.getWorldPosition(); // returns x / y as a FlxPoint
	```

* #### Screen position (relative)
	
	```haxe
	FlxG.mouse.screenX
	FlxG.mouse.screenY
	FlxG.mouse.getScreenPosition(); // returns screenX / screenY as a FlxPoint
	```

## Mouse wheel

The current "delta" value of mouse wheel is provided in a simple `Int` property. If the wheel has just been scrolled up, it will have a positive value and vice versa. If it wasn't scrolled during the current frame, it's 0.

```haxe
if (FlxG.mouse.wheel != 0)
{
	// Mouse wheel logic goes here, for example zooming in / out:
	FlxG.camera.zoom += (FlxG.mouse.wheel / 10);
}
```

## Flash native cursor API

AS3-Flixel used a simple `Sprite` to display a bitmap graphic that is synchronized with the mouse position every frame. This approach is not optimal, as it causes what is commonly referred to as "mouse lag" - the cursor sprite lags behind the actual mouse position. Depending on the game's framerate and the player's mouse speed, this can be very noticeable and thus have a negative impact on the overall experience.

HaxeFlixel leverages the [flash native cursor API](http://www.adobe.com/devnet/flashplayer/articles/native-mouse-cursors.html) for better mouse cursor performance. However, there are certain restrictions to native cursors:

 * They can not exceed 32x32 pixels
 * No negative cursors are allowed, and the positive offsets are limited to the size
 * The targeted flash player version must be 10.2 or higher

Because of this, using the native cursor API is completely optional, see the section on the `FLX_NO_NATIVE_CURSOR` conditional.

### Custom native cursors

You can use `FlxG.mouse.load()` for native cursors as usual, but if you want more fine-grained control, you can use the following functions:

```haxe
FlxG.mouse.setSimpleNativeCursorData("custom", BitmapData);
FlxG.mouse.registerNativeCursor("custom", MouseCursorData);
```

You can find more information on the `MouseCursorData` object [here](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/ui/MouseCursorData.html).


Use `FlxG.mouse.setNativeCursor()` to switch to an already registered native cursor.

## Conditionals

For general information on conditionals, please refer to [this page](http://haxeflixel.com/documentation/compiler-conditionals/).

* ### `FLX_NO_MOUSE_ADVANCED`
	
	By default, there are event listeners set up for both the middle and the right mouse button. There are two reasons for wanting to disable this:

	* it requires a minimum flash player version of 11.2
	* it removes the right-click menu of the flash-player

* ### `FLX_NO_NATIVE_CURSOR`

	This disables the native cursor API on the flash target. For more info, check the "Flash native cursor API"-section above.

* ### `FLX_NO_MOUSE`

	This can be used to remove all mouse-cursor-related logic from HaxeFlixel for optimization purposes, which can make sense on mobile targets, which is why it makes sense to combine this with `if="mobile"` in your `Project.xml`.
