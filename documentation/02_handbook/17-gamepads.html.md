```
title: "Gamepads"
```

Gamepad Input for HaxeFlixel is provided through the FlxGamepad class and is available through `FlxG.gamepads` and the `InputFrontEnd`. Gamepads are made available through the openfl `JoystickEvent` api.

The api has been designed to make working with them similar to other HaxeFlixel inputs.

### Example Usage

``` haxe
class PlayState extends FlxState
{
	override public function create():Void 
	{
		// Getting first availble gamepad, there maybe multple players ;)
		_gamePad = FlxG.gamepads.lastActive;
	}

	override public function update():Void 
	{
		super.update();

		if (_gamePad.pressed("id"))
		{
			//do something when the button id is pressed
		}

		if (_gamePad.getAxis("id") != 0)
		{
			//do something when a gamepad joystick axis has changed
		}
	}
}

```

## Using button IDs

Since gamepads have a variety of manufacturers their keycodes provided to HaxeFlixel api differ from model to model. HaxeFlixel has collected some GamepadIDs from popular gamepads such as `xbox` and `playstation`.

You can see an example of using buttons IDs for multiple gamepad types in the HaxeFlixel demo [GamepadTest](https://github.com/HaxeFlixel/flixel-demos/tree/dev/Input/GamepadTest).

HaxeFlixel has collected the following GamePad ID mappings:
- [Xbox](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/XboxButtonID.hx)
- [PS3](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/PS3ButtonID.hx)
- [Ouya](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/OUYAButtonID.hx)
- [Logitech](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/LogitechButtonID.hx)

To add more ID maps you can work out the IDs from tracing the OpenFL `JoystickEvent` api [handlers here](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/FlxGamepadManager.hx#L310).


Using button maps the code from above can then look like something this:

``` haxe
class PlayState extends FlxState
{
	override public function create():Void 
	{
		// Getting first availble gamepad
		_gamePad = FlxG.gamepads.lastActive;
	}

	override public function update():Void 
	{
		super.update();

		if (_gamePad.pressed(XboxButtonID.A))
		{
			//do something when the button A is pressed
		}

		if (_gamePad.getAxis(XboxButtonID.LEFT_ANALOGUE_X) != 0)
		{
			//do something when the left gamepad joystick axis has changed
		}
	}
}

```

### Conditional to remove gamepads

``` haxe
FLX_NO_GAMEPAD
```

HaxeFlixel includes a [conditional](http://haxeflixel.com/haxeflixel-conditionals) to omit using Gamepads if you are developing for a platform such as mobile or your game just isn't designed for them.
