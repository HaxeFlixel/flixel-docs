```
title: "Cheat Sheet"
```

## [FlxSprite](http://haxeflixel.com/documentation/flxsprite) (Base)

```haxe
package;

import flixel.FlxSprite;
import flixel.FlxG;

class MySprite extends FlxSprite
{
	public function new()
	{
		super();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
```


## [FlxState](http://haxeflixel.com/documentation/flxstate) (Base)

```haxe
package;

import flixel.FlxState;
import flixel.FlxG;

class MyState extends FlxState
{
    override public function create():Void
    {
    	super.create();
    }

    override public function update(elapsed:Float):Void
    {
    	super.update(elapsed);
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}
```


## Switch [FlxState](http://haxeflixel.com/documentation/flxstate)

```haxe
FlxG.switchState(new MyState());
```

## Load [FlxSprite](http://haxeflixel.com/documentation/flxsprite)

```haxe
loadGraphic("assets/my_sprite.png");

// OR dynamically create a rect
makeGraphic(100, 100, 0xFFFFFFFF); // width, height, color (AARRGGBB hexadecimal)
```

## FlxText

* **setFormat**(Font, Size, Color, Alignment)
* **setBorderStyle**(Style, Color, Size)

```haxe
import flixel.text.FlxText;
import flixel.util.FlxColor;
```

```haxe
myText = new FlxText(0, 0, 500); // x, y, width
myText.text = "Hello World";
myText.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
myText.setBorderStyle(OUTLINE, FlxColor.RED, 1);
```


## FlxButton

```haxe
import flixel.ui.FlxButton;
```

```haxe
myButton = new FlxButton(0, 0, "Label", myCallback);

// Custom graphics
myButton.loadGraphic("assets/custom.png");
```

```haxe
private function myCallback():Void
{
}
```

* **myButton.label** is a `FlxText`, use `setFormat()` and `setBorderStyle()` to customise.


## Sounds and Music
Declare each file on `Project.xml`, with an unique `id`.

```xml
<assets path="assets">
	<music path="music_1.ogg" id="music_1" />
	<sound path="sound_1.ogg" id="sound_1" />
</assets>
```
Play on your code:

```haxe
FlxG.sound.play("sound_1");
// Loop music
FlxG.sound.playMusic("music_1");
```

## Keyboard Input

```haxe
// 'A' key
if (FlxG.keys.justPressed.A) {}
if (FlxG.keys.pressed.A) {}
if (FlxG.keys.justReleased.A) {}

// Checking multiple keys:
if (FlxG.keys.anyPressed([RIGHT, D])) {}
```

#### Keys
`ANY`

`A`...`Z`

`UP` `DOWN` `LEFT` `RIGHT`

`SPACE` `ENTER` `ESCAPE`

`ZERO` `ONE` `TWO` `THREE`...`NINE`

`F1`...`F12`
 
`ALT`
`BACKSLASH`
`BACKSPACE`
`CAPSLOCK`
`CONTROL`
`DELETE`
`HOME`
`INSERT`
`QUOTE`
`PERIOD`
`PLUS`
`MINUS`
`PAGEUP`
`PAGEDOWN`
`RBRACKET`
`GRAVEACCENT`
`TAB`
`SLASH`
`SEMICOLON`

`NUMPADZERO` `NUMPADONE` `NUMPADTWO`...`NUMPADNINE`


## [Mouse](http://haxeflixel.com/documentation/mouse) Input

```haxe
if (FlxG.mouse.pressed) {}
if (FlxG.mouse.justPressed) {}
if (FlxG.mouse.justReleased) {}
```

#### Positional Data
```haxe
// Relative to world space
FlxG.mouse.x;
FlxG.mouse.y;

// Relative to screen
FlxG.mouse.screenX;
FlxG.mouse.screenY;
```

#### Wheel (mouse scroll)
Current "delta" value of mouse wheel. If the wheel was just scrolled up, it will have a positive value. If it was just scrolled down, it will have a negative value. If it wasn't just scroll this frame, it will be 0.

```haxe
FlxG.mouse.wheel;
```

## Touch Input

```haxe
for (touch in FlxG.touches.list)
{
	if (touch.justPressed) {}
	if (touch.pressed) {}
	if (touch.justReleased) {}
}
```

#### Positional Data
```haxe
// Relative to world space
touch.x;
touch.y;
        
// Relative to screen
touch.screenX;
touch.screenY;
```

* `touchPointID`: The unique ID of this touch.

* `overlaps(objectOrGroup)`: Checks for overlap between this touch and another `FlxObject` or `FlxGroup`.


## Swipes (Input)

"Swipes" from both mouse and touch input that have just been released:

```haxe
for (swipe in FlxG.swipes)
{
    // swipe.startPosition (FlxPoint)
    // swipe.endPosition (FlxPoint)
    
    // swipe.id (Int)

    // swipe.distance (Float)
    // swipe.angle (Float)
    // swipe.duration (Float)
}
```


## FlxSignal

```haxe
import flixel.util.FlxSignal;
```

```haxe
// for signals that don't need data, use FlxSignal
var signal = new FlxSignal();
// for signals that need data, use FlxTypedSignal with the correct function type
var stringSignal = new FlxTypedSignal<String->Void>();
```

Note: `FlxSignal` is nothing but a convenient shortcut for `FlxTypedSignal<Void->Void>`

```haxe
signal.add(voidCallback); // type must be Void->Void
stringSignal.add(stringCallback); // type must be String->Void
```

```haxe
function voidCallback()
{
	trace("Hello");
}
function stringCallback(text:String)
{
	trace(text);
}
```

```haxe
// this will print "Hello World"
signal.dispatch();
stringSignal.dispatch("World");
```

You can have up to 4 parameters in your signal:
```haxe
var collisionNotify = new FlxTypedSignal<FlxObject->FlxObject->Bool->Bool->Void>();
collisionNotify.add(collisionCallback);

function collisionCallback(source:FlxObject, target:FlxObject, shouldKillSource:Bool, shouldKillTarget:Bool):Void (...)
```

__Don't forget to clean up the signal when your object is destroyed:__
```haxe
signal = FlxDestroyUtil.destroy(signal);
stringSignal = FlxDestroyUtil.destroy(stringSignal);
```


## FlxTimer

```haxe
import flixel.util.FlxTimer;
```

```haxe
// time (seconds), callback, loops
new FlxTimer(10.0, myCallback, 3);
```

```haxe
private function myCallback(Timer:FlxTimer):Void
{
}
```
* Setting `loops` to `0` results in an endless loop.
* `reset(?NewTime)` restarts the timer, optionally with a new duration.
* `cancel()` stops the timer and removes it from the timer manager.


## FlxRandom

```haxe
// (Int) between 0 and 10
FlxG.random.int(0, 10);

// (Float) between 0.0 and 10.0
FlxG.random.float(0.0, 10.0);

// (Bool) Chance by percent
FlxG.random.bool(50); // 50% chance to return 'true'
FlxG.random.bool(10); // 10% chance to return 'true'
```

## [FlxTween](http://haxeflixel.com/documentation/flxtween/)

[Check the demo](http://haxeflixel.com/demos/FlxTween/) to visualize all `FlxTween` types.
* **tween**(Object, Values, Duration, ?Options)

```haxe
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
```

```haxe
// Moves sprite to position (100, 200) in 3 seconds
FlxTween.tween(sprite, { x: 100, y: 200 }, 3.0, { ease: FlxEase.quadInOut, complete: myCallback });
```

```haxe
private function myCallback(Tween:FlxTween):Void
{
}
```

## FlxTween Options

#### ease
```haxe
{ ease: FlxEase.quadInOut }
```

#### complete
```haxe
{ complete: callbackFunction }
```

```haxe
private function callbackFunction(Tween:FlxTween):Void
{
}
```

#### type
```haxe
{ type: FlxTween.PINGPONG }
```
* **FlxTween.BACKWARD:** plays tween in reverse direction
* **FlxTween.LOOPING:** restarts immediately when it finishes.
* **FlxTween.ONESHOT:** stops and remove itself from its core container when it finishes.
* **FlxTween.PERSIST:** stops when it finishes.
* **FlxTween.PINGPONG:** plays tween hither and thither

#### loopDelay
```haxe
{ loopDelay: 1.0 } // 1 second
```

#### startDelay
```haxe
{ startDelay: 2.0 } // 2 seconds
```

## FlxEase List

[Check the demo](http://haxeflixel.com/demos/FlxTween/) to visualize all `FlxEase` types.

* `backIn`, `backInOut`, `backOut`


* `bounceIn`, `bounceInOut`, `bounceOut`


* `circIn`, `circInOut`, `circOut`


* `cubeIn`, `cubeInOut`, `cubeOut`


* `elasticIn`, `elasticInOut`, `elasticOut`


* `expoIn`, `expoInOut`, `expoOut`


* `quadIn`, `quadInOut`, `quadOut`


* `quartIn`, `quartInOut`, `quartOut`


* `quintIn`, `quintInOut`, `quintOut`


* `sineIn`, `sineInOut`, `sineOut`


## Containers ([FlxGroup](http://haxeflixel.com/documentation/flxgroup))

`FlxGroup` is a shortcut for `FlxTypedGroup<FlxBasic>`. Use `FlxTypedGroup<MyOwnClass>` if you need to access your own variables and functions when iterating over the container.

### Iteration
```haxe
for (member in myGroup)
{
	member.x += 10;
	member.mySpecificFunction(); // myGroup = FlxTypedGroup<MyOwnClass>
}
```


## Collision

```haxe
FlxG.overlap(ObjectOrGroup1, ObjectOrGroup2, myCallback);
```

```haxe
private function myCallback(Object1:FlxObject, Object2:FlxObject):Void
{
}
```

Or use `FlxG.collide()` which calls `FlxG.overlap()` and presets the `ProcessCallback` parameter to `FlxObject.separate()`.

## Pixel Perfect Collision

**FlxG.pixelPerfectOverlap**(Sprite, Sprite2)


## Drawing Shapes

**Dynamically draw:** circle, ellipse, line, polygon, triangle, rect, round rect and rect complex.

```haxe
using flixel.util.FlxSpriteUtil;
```

Haxe docs about the `using` keyword: [haxe.org/manual/using](http://haxe.org/manual/using).

```haxe
var canvas = new FlxSprite();
canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
add(canvas);
```

The last argument of `makeGraphic()` is `Unique`, whether the graphic should be an unique instance in the graphics cache, if you create multiple graphics like this, set it to `true` to avoid conflicts.

```haxe
var lineStyle = { color: FlxColor.RED, thickness: 1 };
var fillStyle = { color: FlxColor.RED, alpha: 0.5 };
```

```haxe
// Circle
canvas.drawCircle(X, Y, Radius, Color, lineStyle, fillStyle);

// Ellipse
canvas.drawEllipse(X, Y, Width, Height, Color, lineStyle, fillStyle);

// Line
canvas.drawLine(StartX, StartY, EndX, EndY, lineStyle);

// Polygon
var vertices = new Array<FlxPoint>();
vertices[0] = new FlxPoint(0, 0);
vertices[1] = new FlxPoint(100, 0);
vertices[2] = new FlxPoint(100, 300);
vertices[3] = new FlxPoint(0, 100);
canvas.drawPolygon(vertices, Color, lineStyle, fillStyle);

// Triangle
canvas.drawTriangle(X, Y, Height, Color, lineStyle, fillStyle);

// Rect
canvas.drawRect(X, Y, Width, Height, Color, lineStyle, fillStyle);

// Round Rect
canvas.drawRoundRect(X, Y, Width, Height, EllipseWidth, EllipseHeight, Color, lineStyle, fillStyle);

// Rect Complex
canvas.drawRoundRectComplex(X, Y, Width, Height, TopLeftRadius, TopRightRadius, BottomLeftRadius, BottomRightRadius, Color, lineStyle, fillStyle);
```

Use `canvas.fill(FlxColor.TRANSPARENT);` to clear the canvas.


## HUD

```haxe
// prevents the sprite to scroll with the camera
scrollFactor.set(0, 0);
```


## Debugger

Press `~ key` to open it during runtime, or open by code with `FlxG.debugger.visible = true`.

```haxe
// Log
FlxG.log.add("My var: " + myVar);
// or
FlxG.log.redirectTraces = true;
trace("My var: ", myVar);

// Watch
FlxG.watch.add(object, "property");
```


## Hiding Cursor

```haxe
FlxG.mouse.visible = false;
```


## Adding Gravity

```haxe
acceleration.y = 600;
```
