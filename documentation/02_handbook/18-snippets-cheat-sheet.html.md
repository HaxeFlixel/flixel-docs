```
title: "Snippets Cheat Sheet"
```


## [Game Object](http://haxeflixel.com/documentation/FlxSprite) (Base)

```haxe
package;

import flixel.FlxSprite;
import flixel.FlxG;

class MyObject extends FlxSprite
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

## [State](http://haxeflixel.com/documentation/FlxState) (Base)

```haxe
package;

import flixel.FlxState;
import flixel.FlxG;

class MyState extends FlxState
{
    override public function create():Void
    {

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

## Switch [State](http://haxeflixel.com/documentation/FlxState)

```haxe
FlxG.switchState( new MyState() );
```

## Load [Sprite](http://haxeflixel.com/documentation/FlxSprite)

```haxe
loadGraphic("assets/my_sprite.png");
```

## Texts

```haxe
import flixel.text.FlxText;
```

```haxe
myText = new FlxText(0, 0, 500); // x, y, width
myText.text = "Hello World";
myText.size = 20;
myText.font = "assets/font.ttf";
myText.alignment = "center"; // or "left", "right"
myText.color = 0xFFFFFF;
myText.borderColor = 0x000000;
myText.borderSize = 1;
myText.borderStyle = FlxText.BORDER_OUTLINE;
add(myText);
```

## Buttons

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
	<music path="music_1.mp3" id="music_1" />
	<sound path="sound_1.wav" id="sound_1" />
</assets>
```
Play on your code:

```haxe
FlxG.sound.play("sound_1");

// Loop music
FlxG.sound.music.play("music_1");
```

(Recommended: `OGG` or `MP3` for music files, and `WAV` for sounds effects).

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
`A`...`Z`

`UP` `DOWN` `LEFT` `RIGHT`

`SPACE` `ENTER` `ESCAPE` `ANY`

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

## Timers

```haxe
import flixel.util.FlxTimer;
```

```haxe
// time (seconds), callback, loops
FlxTimer.start(10.0, myCallback, 3);

// Callback
private function myCallback(Timer:FlxTimer):Void
{
}
```
Setting `loops` to `0` results on endless loop.

## Random Numbers

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

## Tweens

```haxe
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
```

```haxe
// Single variable
// (object, property, to, duration (seconds), options)

FlxTween.singleVar(sprite, "alpha", 0.0, 1.0, { ease: FlxEase.quadInOut, complete: myCallback });

// Callback
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
    
    // Use FlxTypedGroup if you need to call non-FlxObject functions or variables:
    member.customFunction();
}
```

## Collision

#### FlxG.overlap()

```haxe
FlxG.overlap(object1, object2, myOverlapCallback);
```

```haxe
myOverlapCallback(Object1:FlxObject,Object2:FlxObject):Void
{
}
```
`FlxG.overlap()` only checks for collision, use `FlxG.collide()` to keep objects apart.

## Casting

```haxe
var mySprite = cast(myFlxObject, FlxSprite);
```

## HUD

```haxe
scrollFactor.set(0, 0);
```

## Adding Gravity

```haxe
acceleration.y = 600;
```

## Debug Console
Press `~ key` during runtime to open it.

```haxe
// Log
trace("My var: " + myVar);

// Watch
FlxG.watch.add(object, "property");
```

## Hiding Cursor

```haxe
FlxG.mouse.hide();
FlxG.mouse.show(); // show again
```