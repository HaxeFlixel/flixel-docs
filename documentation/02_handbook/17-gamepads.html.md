```
title: "Gamepads"
```

Gamepad Input for HaxeFlixel is provided through the FlxGamepad class and is available through `FlxG.gamepads` and the `InputFrontEnd`. Gamepads are made available through the openfl `JoystickEvent` api.

Since gamepads have a variety of manufacturers their keycodes provided to HaxeFlixel API differ from model to model. HaxeFlixel has collected some GamepadIDs from popular gamepads such as `xbox` and `playstation`.

You can see an example of using buttons IDs for multiple gamepad types in the HaxeFlixel demo [GamepadTest](https://github.com/HaxeFlixel/flixel-demos/tree/dev/Input/GamepadTest).

HaxeFlixel has collected the following GamePad ID mappings:
- [Xbox](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/XboxButtonID.hx)
- [PS3](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/PS3ButtonID.hx)
- [OUYA](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/OUYAButtonID.hx)
- [Logitech](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/LogitechButtonID.hx)

Here's some example logic for basic detection of Xbox 360 controller input:

``` haxe
class PlayState extends FlxState
{
	private var _gamePad:FlxGamePad;

	override public function update():Void 
	{
		super.update();

		_gamePad = FlxG.gamepads.get(0); //get the first gamepad

		if (_gamePad.pressed(XboxButtonID.A))
		{
			//do something when the A button of the Xbox 360 controller is pressed
		}

		if (_gamePad.getAxis(XboxButtonID.LEFT_ANALOGUE_X) != 0)
		{
			//do something when the left analogue stick of the Xbox 360 controller has been moved
		}
	}
}

```

If you want to support a controller that HaxeFlixel doesn't provide the IDs for, the following methods of FlxGamePad should be helpful for working out what those IDs are:

- `firstPressedButtonID()`
- `firstJustPressedButtonID()`
- `firstJustReleasedButtonID()`

### Conditional to remove gamepads

``` haxe
FLX_NO_GAMEPAD
```

HaxeFlixel includes a [conditional](http://haxeflixel.com/haxeflixel-conditionals) to omit using Gamepads for optimization purposes if you are developing for a platform such as mobile or your game just isn't designed for them.
