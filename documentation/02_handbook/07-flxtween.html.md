```
title: "FlxTween"
apiPath: tweens/FlxTween.html
```

A `FlxTween` allows you to create smooth interpolations and animations easily. Tweening is short for [inbetweening](http://en.wikipedia.org/wiki/Inbetweening): you only have to specify start and end values and the `FlxTween` class will generate all values between those two. If you want to see a `FlxTween` in action, this [tween demo](http://haxeflixel.com/demos/FlxTween/) is available.

For example, if you want to move a `FlxSprite` across the screen, this code snippet would do it:

```haxe
sprite.x = 200;
sprite.y = 200;

FlxTween.tween(sprite, { x: 600, y: 800 }, 2);
```

The first two lines specify the start position of the sprite, because the `tween()` method assumes the current position is the starting position.

The first parameter is the object you want to act upon; the second parameter is the map which contains the properties you want to interpolate, and their desired target values. Here, we want to translate the sprite in x to position 600 and in y to position 800. The third parameter specifies the duration of the tween in seconds, which in this case is 2 seconds.

## Cancelling a Tween

If you start a tween using the code above, it will run until the desired values are reached, then stop. As the `tween()` method returns an object of type `FlxTween`, keeping this object in a variable allows you to access the current tween running if you wish to control it.

For example, this code stops the translation of the sprite if the player presses the spacebar of his keyboard:

```haxe
var tween:FlxTween;

public function new()
{
	super();
	// set up sprite
	tween = FlxTween.tween(sprite, { x:600, y:800 }, 2);
}

override public function update(elapsed:Float)
{
	super.update(elapsed);
	
	if (FlxG.keys.justPressed.SPACE)
		tween.cancel();
}
```

## Tweening Options

The `tween()` method takes an optional fourth parameter which is a map of options.

Possible values are:

- `type`: choose one of these:

	- **FlxTween.ONESHOT**: stops and removes itself from its core container when it finishes;
	- **FlxTween.PERSIST**: stops when it finishes. Unlike **ONESHOT**, this type of tween stays attached to the core container when it finishes. This means you can keep a reference to this tween and call `start()` whenever you need it. This does not work with **ONESHOT**;

	- **FlxTween.LOOPING**: restarts immediately when it finishes;
	- **FlxTween.PINGPONG**: plays tween "hither and thither". This is like **LOOPING**, but every second execution is in reverse direction;
	
	- **FlxTween.BACKWARD**: plays tween in reverse direction.

- `onComplete`: a callback function, which is called once the tween has finished. This is called every time the tween has finished one execution and comes in handy for repeating tweens (**LOOPING** and **PINGPONG**). The method must take a `FlxTween` and return nothing.

- `ease`: an optional easer function. This can be used to make the beginning and end of a tween smoother. The [`FlxEase`](http://api.haxeflixel.com/types/flixel/tweens/FlxEase.html) class provides many static methods for this which should cover most cases. The following list shows all functions from `FlxEase`. In all of these, `In` can be replaced by `Out` or `InOut`, depending on where you want to apply the easing effect: at the beginning of the animation, at the end or at both sides.

	- `backIn`
	- `bounceIn`
	- `circIn`
	- `cubeIn`
	- `elasticIn`
	- `expoIn`
	- `quadIn`
	- `quartIn`
	- `quintIn`
	- `sineIn`

- `startDelay`: time to wait before starting this tween, in seconds.

- `loopDelay`: time to wait before this tween is repeated, in seconds. This only applies to **LOOPING** and **PINGPONG**.

For example:

```haxe
public function new()
{
	super();
	// set up sprite
	sprite.x = 200;
	sprite.y = 200;
	FlxTween.tween(sprite, { x: 600, y: 800 }, 2, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut, onComplete: changeColor, startDelay: 1, loopDelay: 2 });
}

function changeColor(tween:FlxTween):Void
{
	// change the color of the sprite here
}
```

This code moves the sprite constantly between the two points (200|200) and (600|800), smoothly accelerating and decelerating. Each time the sprite arrives at one of those two points, its color changes. The animation starts after 1 second and then the sprite pauses at each point for 2 seconds.

## Special Tweens

There are many more tweening methods in `FlxTween`, which are used for special cases:

#### `color()`

Tweens the red, green and blue part of a color independently, because normal tweening would screw up the colors.

Usage: **color**(Sprite : `FlxSprite`, Duration : `Float`, FromColor : `Int`, ToColor : `Int`, ?FromAlpha : `Float`, ?ToAlpha : `Float`, ?Options : `TweenOptions`)

Notice that unlike in the `tween()` method, the duration is specified before the color values and you have to enter the start and the end value. The options are the same as described above.

#### `angle()`

This method is for tweening the angle of a `FlxSprite`.

Usage: **angle**(Sprite : `FlxSprite`, FromAngle : `Float`, ToAngle : `Float`, Duration : `Float`, ?Options : `TweenOptions`)

#### Motion and Path Tweens

The `FlxTween` class also contains the methods `linearMotion()`, `quadMotion()`, `cubicMotion()` and `circularMotion()`, which make objects follow straight lines, smooth paths or circles.

The methods `linearPath()` and `quadPath()` can be used for longer paths defined through an array of points, instead of a fixed number of points.

If you want to use these methods please refer to the [`FlxTween` API](http://api.haxeflixel.com/flixel/tweens/FlxTween.html). 
