```
title: "Actions"
apiPath: input/actions/index.html
```

Players & designers care about *actions* (Mario *jumps*, Samus *shoots*, Captain 
Falcon *turns*, *brakes*, and *accelerates*), whereas computers care about 
*inputs* (The W key is `PRESSED`, the Left Mouse button was `JUST_RELEASED`, 
Gamepad #2's analog stick is `MOVED` with values `x=0.4, y=-0.5`).

`FlxAction`s let you organize your game around actions, removing tight coupling 
with specific input bindings and providing various other benefits as well.
`FlxAction`s are also required for those who wish to use the Steam Input API.

## `FlxAction`

`FlxAction`s come in two varieties: digital and analog. Digital is for on/off 
actions like "JUMP" and "SHOOT". Analog is for things that need a range of 
values, like jumping with more or less force, or moving a player or camera 
around. 

Digital actions let you do things like: `if(SHOOT.check()) doShoot();` in your 
update loop rather than have a big ugly block that accounts for every input 
device you support.

Analog actions let you do things like `moveCharacter(MOVE.x,MOVE.y)` or 
`fireLaserBeam(LASER_INTENSITY.x)`, nicely hiding whatever devices are actually
driving the input, and just providing you with the resulting floating point 
values.

To create a `FlxAction`:

```haxe
var jump = new FlxActionDigital();
var move = new FlxActionAnalog();
```

You can optionally pass in a name and a callback in the constructor. If you 
provide a callback, it will fire whenever the action is triggered.

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
action at least once per global update tick to ensure accurate input, but don't 
worry about calling `update()` or `check()` *too* often, an internal safety 
prevents the internal state from updating more than once per tick.

If you don't want to manually update `FlxAction`s, use the `FlxActionManager`, 
which will keep them updated for you.

Of course, `FlxAction`s won't trigger at all until you attach some 
`FlxActionInput`s.

## `FlxActionInput`
=============

A `FlxActionInput` represents a specific input event on a specific input device.
These come in digital and analog forms for every device that Flixel supports. 
The following are provided by default, but you can create your own by extending `FlxActionInputDigital` and `FlxActionInputAnalog`:

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




