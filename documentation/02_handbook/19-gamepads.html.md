```
title: "Gamepads"
apiPath: input/gamepad/index.html
```

Gamepad input for HaxeFlixel is provided through the `FlxGamepad` class and is available through `FlxG.gamepads` and the `InputFrontEnd`.

Since gamepads have a variety of manufacturers their keycodes provided to HaxeFlixel API differ from model to model. HaxeFlixel provides mappings that map buttons and sticks to common IDs for convenient use. Mappings are available for:

- XInput (Xbox 360, Xbox One, etc)
- PS4
- OUYA
- Logitech
- WiiRemote
- Mayflash WiiRemote
- MFi
- PS Vita

Here's some example logic for basic detection of Xbox 360 controller input:

``` haxe
import flixel.FlxG;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;

class PlayState extends FlxState
{
    override public function update(elapsed:Float):Void 
    {
        super.update(elapsed);

        // Important: can be null if there's no active gamepad yet!
        gamepad = FlxG.gamepads.lastActive;
        if (gamepad != null)
        {
            updateGamepadInput(gamepad);
        }
    }

    private function updateGamepadInput(gamepad:FlxGamepad):Void
    {
        if (gamepad.pressed.A)
        {
            trace("The A button of the Xbox 360 controller is pressed.");
        }
		
        if (gamepad.analog.justMoved.LEFT_STICK_X)
        {
            trace("The x axis of the left analog stick of the Xbox 360 controller has been moved.");
        }
    }
}
```

If you want to support a controller that HaxeFlixel doesn't provide the IDs for, the following methods of `FlxGamePad` methods should be helpful for working out what those IDs are:

- `firstPressedButtonID()`
- `firstJustPressedButtonID()`
- `firstJustReleasedButtonID()`

### Conditional to remove gamepads

``` haxe
FLX_NO_GAMEPAD
```

HaxeFlixel includes a [conditional](http://haxeflixel.com/documentation/haxeflixel-conditionals/) to omit using gamepads for optimization purposes if you are developing for a platform such as mobile, or your game just isn't designed for them.
