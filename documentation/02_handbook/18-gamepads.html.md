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

For most gamepads HaxeFlixel will automatically detect the model and abstract the API inputs under a common "universal" gamepad model based on the Xbox 360 layout. The underlying device-specific "raw" inputs are still available for you to poll direclty, if you choose.

Here's some example logic for basic detection using the "universal" gamepad API:

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
            trace("The bottom face button of the controller is pressed.");
        }
		
        if (gamepad.analog.justMoved.LEFT_STICK_X)
        {
            trace("The x axis of the left analog stick of the controller has been moved.");
        }
    }
}
```

In this case, ```gamepad.pressed.A``` checks whether the bottom face button is pressed. On a PS4 controller this would be the "X" button.

Also, ```gamepad.pressed.A``` is an optimized shorthand for ```gamepad.pressed.check(FlxGamepadInputID.A)```. You want to use the latter syntax if you need to check a variable (which would be the case if the user can customize their inputs).

If you wanted to check a device-specific input, you would use the ```checkRaw``` function, like this: ```gamepad.pressed.checkRaw(PS4ID.X)```

Device-specific inputs can be found in the ```flixel.input.gamepad.id``` package.

If you want to support a controller that HaxeFlixel doesn't provide the IDs for, the following methods of `FlxGamePad` methods should be helpful for working out what those IDs are:

- `firstPressedButtonID()`
- `firstJustPressedButtonID()`
- `firstJustReleasedButtonID()`

### Conditional to remove gamepads

``` haxe
FLX_NO_GAMEPAD
```

HaxeFlixel includes a [conditional](http://haxeflixel.com/documentation/haxeflixel-conditionals/) to omit using gamepads for optimization purposes if you are developing for a platform such as mobile, or your game just isn't designed for them.
