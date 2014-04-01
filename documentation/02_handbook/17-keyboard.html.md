```
title: "Keyboard"
```

Keyboard input for HaxeFlixel is provided through the `FlxKeyboard` class and is available through `FlxG.keys`.

## Key Lists

An object of type `FlxKeyList` contains a `Bool` for each key on the keyboard. The values are kept as an array internally, but you can easily refer to them by using special instance variables named after the key. For a full list of all available names look at the `FlxKeyList` documentation [here](http://api.haxeflixel.com/types/flixel/input/keyboard/FlxKeyList.html).

`FlxKeyboard` uses the three key lists `pressed`, `justPressed` and `justReleased` to keep track of the keys. `pressed` contains `true` for all keys that are currently pressed. `justPressed` only contains `true` for all keys that have been pressed since the last frame.

Here's an example of how to put it all together:

``` haxe
override public function update():Void
{
	if (FlxG.keys.pressed.UP)
	{
		// The up arrow key is currently pressed
		// This code is executed every frame, while the key is pressed
	}
	
	if (FlxG.keys.justPressed.LEFT)
	{
		// The left arrow key has just been pressed
		// This code is only execute once, on the frame immediately after the key has been pressed
	}
	
	if (FlxG.keys.justReleased.LEFT)
	{
		// The left arrow key has just been released
		// This code is only execute once, on the frame immediately after the key has been released
	}

	super.update();
}
```

## Checking multiple keys

You can check multiple keys at once using the `anyPressed()`, `anyJustPressed()` and `anyJustReleased()` methods of `FlxKeyboard`. This allows to bind multiple keys to one action easily, for example controlling the player with either WASD or the arrow keys. These methods take an `Array` of key names (as `String`s) and return true if any of the given keys has the desired property.

``` haxe
override public function update():Void
{
	if (FlxG.keys.anyPressed(["LEFT", "A"]))
	{
		// Move left
	}
	
	if (FlxG.keys.anyPressed(["RIGHT", "D"]))
	{
		// Move right
	}

	super.update();
}
```

## Conditionals

For general information on conditionals, please refer to [this page](http://haxeflixel.com/documentation/compiler-conditionals/).

* ### `FLX_NO_KEYBOARD`

	This can be used to remove all keyboard-related logic from HaxeFlixel for optimization purposes, which can make sense on mobile targets, which is why it is combined with `if="mobile"` in the default `Project.xml`.
