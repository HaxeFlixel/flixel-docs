```
title: "Cheat Sheet"
```


## [FlxSprite](http://haxeflixel.com/documentation/FlxSprite) (Base)

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

	override public function update():Void
	{
		super.update();
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
```

## [FlxState](http://haxeflixel.com/documentation/FlxState) (Base)

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

    override public function update():Void
    {
    	super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}
```

## Switch [FlxState](http://haxeflixel.com/documentation/FlxState)

```haxe
FlxG.switchState(new MyState());
```

## Load [FlxSprite](http://haxeflixel.com/documentation/FlxSprite)

```haxe
loadGraphic("assets/my_sprite.png");
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
myText.setFormat("assets/font.ttf", 20, FlxColor.WHITE, "center");
myText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.RED, 1);
```

## FlxButton

```haxe
import flixel.ui.FlxButton;
```

```haxe
myButton = new FlxButton(0, 0, "Label", myCallback);
```

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
if (FlxG.keys.justPressed.A) 
{
}

if (FlxG.keys.pressed.A)
{
}

if (FlxG.keys.justReleased.A) 
{
}
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
if (FlxG.mouse.pressed) 
{
}

if (FlxG.mouse.justPressed) 
{
}

if (FlxG.mouse.justReleased) 
{
}
```

#### Positional Data
```haxe
FlxG.mouse.x;
FlxG.mouse.y;

// Relative to screen
FlxG.mouse.screenX;
FlxG.mouse.screenY;
```

## FlxTimer

```haxe
import flixel.util.FlxTimer;
```

```haxe
// time (seconds), callback, loops
FlxTimer.start(10.0, myCallback, 3);
```

```haxe
private function myCallback(Timer:FlxTimer):Void
{
}
```
Setting `loops` to `0` results in an endless loop.

## FlxRandom

```haxe
import flixel.util.FlxRandom;
```

```haxe
// (Int) between 0 and 10
FlxRandom.intRanged(0, 10);

// (Float) between 0.0 and 10.0
FlxRandom.floatRanged(0.0, 10.0);

// (Bool) Chance by percent
FlxRandom.chanceRoll(50); // 50% chance to return 'true'
FlxRandom.chanceRoll(10); // 10% chance to return 'true'
```

## FlxTween
Check [FlxTween Demo source code](https://github.com/HaxeFlixel/flixel-demos/tree/dev/Effects/FlxTween) for more info.
* **tween**(Object, Values, Duration, ?Options)

```haxe
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
```

```haxe
// Moves sprite to position (100, 200) in 3 seconds
FlxTween.tween(sprite, { x:100, y:200 }, 3.0, { ease: FlxEase.quadInOut, complete: myCallback });
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

## Iterate Over [FlxGroup](http://haxeflixel.com/documentation/flxgroup)

```haxe
for (member in myGroup)
{
	member.x += 10;
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

## HUD

```haxe
// prevents the sprite to scroll with the camera
scrollFactor.set(0, 0);
```

## Debugger

Press `~ key` to open it during runtime, or open by code with `FlxG.debugger.visible = true`.

```haxe
// Log
trace("My var: " + myVar);

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
