```
title: "Gamepads"
apiPath: input/gamepad/index.html
```

Gamepad Input for HaxeFlixel is provided through the FlxGamepad class and is available through `FlxG.gamepads` and the `InputFrontEnd`. Gamepads are made available through the openfl `JoystickEvent` api.

Since gamepads have a variety of manufacturers their keycodes provided to HaxeFlixel API differ from model to model. HaxeFlixel has collected some GamepadIDs from popular gamepads such as `xbox` and `playstation`.

You can see an example of using buttons IDs for multiple gamepad types in the HaxeFlixel demo [GamepadTest](https://github.com/HaxeFlixel/flixel-demos/tree/dev/Input/GamepadTest).

HaxeFlixel has collected the following GamePad ID mappings:
- [Xbox](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/XboxButtonID.hx)
- [PS3](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/PS3ButtonID.hx)
- [PS4](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/PS4ButtonID.hx)
- [OUYA](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/OUYAButtonID.hx)
- [Logitech](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/input/gamepad/LogitechButtonID.hx)

Here's some example logic for basic detection of Xbox 360 controller input:

``` haxe
import flixel.FlxG;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;

class PlayState extends FlxState
{
    private var _gamePad:FlxGamepad;

    override public function update():Void 
    {
        super.update();

        // Important: can be null if there's no active gamepad yet!
        _gamePad = FlxG.gamepads.lastActive;

        if (_gamePad != null)
        {
            gamepadControls();
        }
    }

    private function gamepadControls():Void
    {
        if (_gamePad.pressed(XboxButtonID.A))
        {
            trace("The A button of the Xbox 360 controller is pressed.");
        }
		
        if (_gamePad.getAxis(XboxButtonID.LEFT_ANALOGUE_X) != 0)
        {
            trace("The x axis of the left analogue stick of the Xbox 360 controller has been moved.");
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

HaxeFlixel includes a [conditional](http://haxeflixel.com/documentation/haxeflixel-conditionals/) to omit using Gamepads for optimization purposes if you are developing for a platform such as mobile or your game just isn't designed for them.
