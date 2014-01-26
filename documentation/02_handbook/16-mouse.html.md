```
title: "Mouse"
```

Mouse Input for HaxeFlixel is provided through the FlxMouse class and is available through `FlxG` and the `InputFrontEnd`.

### Example Usage

``` haxe
if (FlxG.mouse.justReleased)
{
	// Run code when the Mouse's left button is justReleased
}

//Can also use
FlxG.mouse.justPressed
FlxG.mouse.pressed

```

### Position data

You can determine the position of the mouse cursor easily with the following:

```haxe
FlxG.mouse.screenX
FlxG.mouse.screenY
FlxG.mouse.getWorldPosition();
FlxG.mouse.getScreenPosition();
```

### Mouse Wheel

The current "delta" value of mouse wheel is provided in a simple Int property. If the wheel was just scrolled up, it will have a positive value. If it was just scrolled down, it will have a negative value. If it wasn't just scroll this frame, it will be 0.

```haxe
if (FlxG.mouse.wheel > 0)
{
	// Do something when the wheel is up
}
```

### FLX_MOUSE_ADVANCED

The FLX_MOUSE_ADVANCED is a conditional to use the extended Mouse api when needed. You can define this [conditional](/documentation/haxeflixel-conditionals) in your OpenFL `project.xml`. It Provides access to the right and middle buttons.


```haxe
FlxG.mouse.pressedRight
FlxG.mouse.justPressedRight
FlxG.mouse.justReleasedRight

FlxG.mouse.pressedMiddle
FlxG.mouse.justPressedMiddle
FlxG.mouse.justReleasedMiddle
```

### Custom Cursor Support

Custom mouse cursors are available through the api using a custom bitmap image in the display list. 

#### Native Cursor

On the Flash player target using a custom bitmap in this way is known to be a performance issue. To overcome this Adobe provided an api for using the native cursor api. HaxeFlixel now uses this by default with Flash only.

To disable the Native cursor for Flash you can use the `project.xml` [conditional](/documentation/haxeflixel-conditionals): 

```haxe
FLX_NO_NATIVE_CURSOR
```

Native cursor are not rendered by your game, it instead uses the operating system apis for cursors, for this reason it has limitations such as the size depending on your platform.

To use a custom native cursor you can use a custom MouseCursorData from the [flash api](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/ui/MouseCursorData.html):

```haxe
FlxG.mouse.registerNativeCursor("custom", <MouseCursorData>)
```

To activate your native cursor use:

```haxe
FlxG.mouse.setNativeCursor("custom");
```
