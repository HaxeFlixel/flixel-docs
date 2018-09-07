```
title: "Actions"
apiPath: input/actions/index.html
```

Players & designers care about *actions* (Mario JUMPS, Samus SHOOTS, Captain 
Falcon TURNS, BRAKES, and ACCELERATES), whereas computers care about *inputs*
(The W key is PRESSED, the Left Mouse button was JUST_RELEASED, Gamepad #2's 
analog stick is MOVED with values (x=0.4, y=-0.5)).

`FlxAction`s are a convenient way to organize your game around actions and 
remove tight coupling with specific input bindings, with various other
benefits as well `FlxAction`s are also required for those who wish to use the 
Steam Input API.

## `FlxAction`s

`FlxAction`s come in two varieties: Digital and Analog. Digital is for on/off 
actions like JUMP and SHOOT. Analog is for things that need a range of values, 
like jumping with more or less force, or moving a player or camera around. 

Digital actions let you do things like: `if(SHOOT.check()) doShoot();` in your 
update loop rather than have a big ugly block that accounts for every input 
device you support.

Analog actions let you do things like `moveCharacter(MOVE.x,MOVE.y)` or 
`fireLaserBeam(LASER_INTENSITY.x)`, nicely hiding whatever devices are actually
driving the input, and just providing you with the resulting floating point 
values.

Creating `FlxAction`s is easy:

```haxe
var jump = new FlxActionDigital();
var move = new FlxActionAnalog();
```

You can pass in a name and a callback to a `FlxAction` in the constructor, but
that's purely optional. If you provide a callback, that callback will fire 
whenever the action is triggered.

If you are managing `FlxAction`s yourself (as opposed to using the action 
manager), you will need to update the actions every frame, either by doing this:

```haxe
function updateLoop()
{
    if(jump.check()) doJump();
    if(move.check()) doMove(move.x,move.y);
}
```

...or this:
```haxe
function updateLoop()
{
    jump.update();
    if(jump.triggered) doJump();
    move.update();
    if(move.triggered) doMove(move.x,move.y);
}
```

`FlxAction.update()` will update the `triggered` property, and fire the callback
if present.

`FlxAction.check()` will update the `triggered` property, fire the callback if present, and return whether `triggered` is now `true`.

Either one is sufficient to keep the action updated. You *must* update each 
action at least once per global update tick to ensure accurate input, but you 
can't break things by calling `update()` or `check()` *too* often, thanks to an internal safety check. If you don't want to manually update `FlxAction`s 
yourself, be sure to read the section on the `FlxActionManager`, which will keep
them updated for you.

Of course, `FlxAction`s won't trigger unless you attach some `FlxActionInput`s.

## `FlxActionInput`s
=============

`FlxActionInput`s come in digital and analog forms for every input device that 
Flixel supports. The following are provided by default, though you can create 
your own by extending `FlxActionInputDigital` and `FlxActionInputAnalog`:

- `FlxActionInputDigitalKeyboard`
- `FlxActionInputDigitalMouse`
- `FlxActionInputDigitalMouseWheel`
- `FlxActionInputDigitalGamepad`
- `FlxActionInputDigitalIFlxInput`
- `FlxActionInputAnalogMouse`
- `FlxActionInputAnalogMouseMotion`
- `FlxActionInputAnalogMousePosition`
- `FlxActionInputAnalogClickAndDragMouseMotion`
- `FlxActionInputAnalogGamepad`

You can attach inputs like this:

```haxe
jump.addKey(SPACE, JUST_PRESSED);
jump.addMouse(LEFT, JUST_PRESSED);
jump.addGamepad(A, JUST_PRESSED, FIRST_ACTIVE);
```

These helper functions are shorthand for creating and attaching inputs like so:
```haxe
jump.add(new FlxActionInputDigitalKeyboard(SPACE, JUST_PRESSED));
jump.add(new FlxActionInputDigitalMouse(LEFT, JUST_PRESSED));
jump.add(new FlxActionInputDigitalGamepad(A, JUST_PRESSED, FIRST_ACTIVE);
```

This will cause the "jump" action to trigger on the frame where any of the
following conditions is met: space bar was just pressed, left mouse button was
just clicked, or the bottom face button on any gamepad was just pressed.




