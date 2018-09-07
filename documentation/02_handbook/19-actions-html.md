```
title: "Actions"
apiPath: input/actions/index.html
```

Players & designers care about *actions* (Mario *jumps*, Samus *shoots*, Captain 
Falcon *turns*, *brakes*, and *accelerates*), whereas computers care about 
*inputs* (The W key is `PRESSED`, the left mouse button was `JUST_RELEASED`, 
gamepad #2's analog stick is `MOVED` with values `x=0.4, y=-0.5`).

The `FlxAction` API provides several benefits over handling every input case 
directly:

- Declutter logic by focusing on actions, not inputs
- Remove tight coupling between specific input bindings and actions
- Makes it easy to refactor your input code
- Makes it easy to support player-defined input bindings
- Makes it easy to handle multiple input devices simultaneously
- Allows use of the Steam Input API
- Makes it easier to implement:
  - AI-controlled players/bots
  - Replay systems (record actions, not inputs, then play them back)

## `FlxAction`

`FlxAction`s come in two varieties: digital and analog. Digital is for on/off 
actions like "JUMP" and "SHOOT". Analog is for things that need a range of 
values, like jumping with more or less force, or moving a player or camera 
around. (`FlxAction`s are triggered by attached `FlxActionInput`s, described in 
the next section).

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
manager), you will need to update the actions every frame, either by doing 
something like this:

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
    move.update();
    if(jump.triggered) doJump();
    if(move.triggered) doMove(move.x,move.y);
}
```

`FlxAction.update()` will update the `triggered` property, fire the callback
if present, and update the `x` and `y` values (if an analog action).

`FlxAction.check()` will update the `triggered` property, fire the callback if present, update the `x` and `y` values (if an analog action), and return the 
value of `triggered`.

Either is sufficient to keep the action updated. You *must* update each 
action at least once per global update tick to ensure accurate input, but if you
accidentally update an action more than once per tick, it's okay -- an internal 
safety check ensures that nothing bad happens.

If you don't want to manually update `FlxAction`s, use the `FlxActionManager`, 
which will keep them updated for you.

## `FlxActionInput`

A `FlxActionInput` represents a specific input event on a specific input device,
like "when the A button on gamepad one is JUST_PRESSED", which you can use to 
trigger a `FlxAction`.

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

These helper functions are a shorthand for this equivalent:
```haxe
jump.add(new FlxActionInputDigitalKeyboard(SPACE, JUST_PRESSED));
jump.add(new FlxActionInputDigitalMouse(LEFT, JUST_PRESSED));
jump.add(new FlxActionInputDigitalGamepad(A, JUST_PRESSED, FIRST_ACTIVE);
```

This will cause the "jump" action to trigger on the frame where any of the
following conditions is met: space bar was just pressed, left mouse button was
just clicked, or the bottom face button on any gamepad was just pressed.

Each `FlxActionInput` class has its own parameters that let you define exactly
when the action should fire. For instance, here is the constructor for `FlxActionInputDigitalKeyboard`:

```haxe
public function new(Key:FlxKey, Trigger:FlxInputState)
```

This requires you to specify a specific key, as well as an input state (`PRESSED`,
`JUST_PRESSED`, `RELEASED`, `JUST_RELEASED`).

Now here's the constructor for `FlxActionInputDigitalGamepad`, note that in 
addition to specifying the button and the trigger state, we also have to specify
which gamepad we're listening for, since there could be more than one:

```haxe
public function new(InputID:FlxGamepadInputID, Trigger:FlxInputState, GamepadID:Int = FlxInputDeviceID.FIRST_ACTIVE)
```

Now let's take a quick look at some analog inputs.

Here's `FlxActionInputAnalogGamepad`:
```haxe
public function new(InputID:FlxGamepadInputID, Trigger:FlxAnalogState, Axis:FlxAnalogAxis = EITHER, GamepadID:Int = FlxInputDeviceID.FIRST_ACTIVE)
```
In addition to having to specify the input (left/right stick or left/right 
trigger), the trigger state, and the gamepad ID, we also have to specify which
analog axis we care about (`X`, `Y`, `EITHER`, `BOTH`). (Note that for 
single-axis analog inputs, such as analog triggers, only the x value will change
and the y value will always be zero).

Another example is `FlxActionInputAnalogMousePosition`:
```haxe
public function new(Trigger:FlxAnalogState, Axis:FlxAnalogAxis = EITHER)
```

Since there's only ever one mouse, we don't need to specify the device, and we don't
need to specify a button since we just want the position. Whenever this action 
updates the `x` and `y` values will match the mouse position.

## `FlxActionSet`

A `FlxActionSet` is little more than a glorified array of `FlxAction`s. There's
little reason to use them directly unless you are using the `FlxActionManager`,
but they can still be a convenient way to call `update()` on all your actions
at once.

## `FlxActionManager`

`FlxActionManager` lets you manage multiple actions without having to update
them manually, and also lets you control action sets. Action sets are groups of
actions that can be selectively activated for specific input devices at specific times, which is great for local multiplayer games, games with complex input, and
games using the Steam Input API.

`FlxActionManager` is not initialized in Flixel by default, you have to add it yourself in your initialization code:

```haxe
var actionManager = new FlxActionManager();
FlxG.inputs.add(actionManager);
```

Once the action manager has been set up, you can simply add actions to it, and
it will ensure that all your actions are kept up to date:

```haxe
//add actions one by one:
actionManager.addAction(jump);
actionManager.addAction(shoot);

//add several actions at once:
actionManager.addActions([action1,action2,action3,action4,action5]);
```

Then in your update loop you can simply check the `triggered` property, or just
wait for callbacks to fired, if you've set any.

```haxe
function updateLoop()
{
    if(jump.triggered) doJump();
    if(shoot.triggered) doShoot();
}
```

### Default action set

What's actually happening when you call `addAction` or `addActions` is that the
manager is asking for both actions *and* the action set you want to add them to:

```haxe
public function addAction(Action:FlxAction, ActionSet:Int = 0):Bool
```

If you don't provide an action set, it assumes you want to add them to the first
one (index 0). And if you haven't defined any action sets, it will create one
for you at index 0, name it "default", and immediately activate it for all
devices.

### Working with action sets

Only ONE action set is considered active at a given time for any given device, 
but multiple devices can be subscribed to the same action set.

For instance, in an asymetrical co-op game where one person drives a tank
and the other mans the turret, gamepad #1 could use action set "drive" and
gamepad #2 could use action set "gunner". The same could go for the mouse,
the keyboard, etc. And in a single-player game you might want to just change
the action set of ALL input devices every time you switch to a different
screen, such as a menu.

`FlxActionManager` lets you:
- ADD action sets
- REMOVE action sets
- ACTIVATE an action set for a specific device
- UPDATE all your action sets at once
- ENFORCE the "only one action set active per device at a time" rule

To create and add an action set, do something like:

```haxe
//where up, down, left, right, select are digital actions
var set = new FlxActionSet("menu", [up, down, left, right, select]);
var menuSetIndex = actionManager.addSet(set);
```

Note that `addSet` returns the action set's index. All operations on action sets
require the action set's index (an `Int`), not its name (a `String`). This is 
for performance reasons. If you forget to store the action set, or otherwise 
lose track of an action set's index, you can query it at any time by passing the
set's name to `getSetIndex()`. Just be sure not to do this repeatedly in 
frequently called loops.

### Steam Input

If you are using the [steamwrap](https://www.github.com/larsiusprime/steamwrap) library, `FlxActionManager` gains the ability
to automatically create action sets from a steamwrap object derived from the
master vdf game actions file that Steam makes you set up. You must then ACTIVATE
one of those action sets for any connected steam controllers, which will 
automatically attach the proper steam action inputs to the actions in the set.
You can also add as many regular `FlxActionInput`s as you like to any actions in
the sets.

```haxe
var config = steamwrap.data.ControllerConfig.fromVDF(myVDF);
actionManager.initSteam(config,digitalCallback,analogCallback);
```

NOTE:
If you are using the Steam Input API and/or a Steam Controller, you MUST use `FlxActionManager` in order to properly process Steam's API via `FlxAction`s.
The only other alternative is to call the steamwrap functions directly.

### JSON parsing

`FlxActionManager` can generate a JSON string representation of your action sets via `exportToJSON()` You can also initialize your action sets by calling
`initFromJSON`, feeding in the parsed object representation of the same format.

The format is:

```
typedef ActionSetJSONArray = 
{
    @:optional var actionSets:Array<ActionSetJSON>;
}

typedef ActionSetJSON =
{
    @:optional var name:String;
    @:optional var analogActions:Array<String>;
    @:optional var digitalActions:Array<String>;
}
```

Which would look something like this in practice:
```json
{
    "actionSets" : [
        {
            "name" : "SomeSet",
            "analogActions" : [
                "some_analog_action_1",
                "some_analog_action_2"
            ],
            "digitalActions" : [
                "some_digital_action_1",
                "some_digital_action_2"
            ]
        },
        {
            "name" : "AnotherSet",
            "analogActions" : [
                "another_analog_action_1",
                "another_analog_action_2"
            ],
            "digitalActions" : [
                "another_digital_action_1",
                "another_digital_action_2"
            ]
        }
    ]
}
```