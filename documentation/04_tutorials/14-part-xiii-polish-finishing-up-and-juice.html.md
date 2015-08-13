```
title: "Part XIII: Polish, finishing up, and juice!"
```

In this section, I'm going to show you a few simple tricks to add some polish and juice to your game. You may have seen me drop a few of these into the code earlier on, but we'll go through a few places now to talk about them.

First up, there's a simple effect we can do with our Camera to have it fade in or out. This works nice for transitions between states or screens.
We can add it to each of our states' create function like so (right before `super.create()`):

```haxe
FlxG.camera.fade(FlxColor.BLACK, .33, true);
```

Then, if you want to fade out (when switching states), you can do something like this:

```haxe
FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
	FlxG.switchState(new PlayState());
});
```

Try adding this logic to all of your states and then see how much of an improvement it gives the flow of your game.

Next, let's give the player a little feedback whenever they get hurt in combat. We're going to make the screen shake briefly. So, go into the enemyAttack function in CombatHUD and, right after we call `FlxG.camera.flash` (another neat little effect you can use in other projects), add:

```haxe
FlxG.camera.shake(0.01, 0.2);
```

So, each time the player gets hurt in combat, the screen will flash white, and will shake a little bit for .2 seconds. Try it out!

I know we've used tweens a few times already, but lets add one to show the enemy getting hurt in combat. We're simply going to make a tween that moves the enemy a few pixels to the right, then triggers a second tween to move the enemy back - each one taking .1 seconds to complete. So, in the makeChoice function of CombatHUD, right before we play the hurt sound for the enemy, add:

```haxe
FlxTween.tween(_sprEnemy, { x:_sprEnemy.x + 4 }, .1, { complete: function(_) {
	FlxTween.tween(_sprEnemy, { x:_sprEnemy.x - 4 }, .1);
}} );
```

Check out how that looks. Tweens are a very simple and powerful tool to make your game feel more active when used properly.

Next, let's add a background effect to our CombatHUD to help bring our the combat screen out from the map a little bit. We're going to copy what's on the camera's buffer, desaturate it, and then apply a FlxWaveSprite to give it a wavy effect. HaxeFlixel has several addons, like FlxWaveSprite or FlxGlitchSprite that can be used for a number of effects.

1. Open up the CombatHUD class and add these two objects:

	```haxe
	private var _sprScreen:FlxSprite;
	private var _sprWave:FlxWaveSprite;
	```

2. In the constructor, we'll initialize these two objects (add this before we create our _sprBack):

	```haxe
	_sprScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
	_sprWave = new FlxWaveSprite(_sprScreen, WaveMode.ALL, 4, -1, 4);
	add(_sprWave);
	```

	First, we make our `_sprScreen`, make it the size of the window, and just leave it empty for now. Then we make a FlxWaveSprite, tell it to target our `_sprScreen`, and set its properties.

3. Next, in `initCombat` we want to make our `_sprScreen` take a copy of whatever is on the camera's buffer and apply it to itself, and then desaturate the image. Our FlxWaveSprite will always copy whatever is on our `_sprScreen` every update automatically.

	```haxe
	#if flash
	_sprScreen.pixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
	#else
	_sprScreen.pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
	#end
	var rc:Float = 1 / 3;
	var gc:Float = 1 / 2;
	var bc:Float = 1 / 6;
	_sprScreen.pixels.applyFilter(_sprScreen.pixels, _sprScreen.pixels.rect, new Point(), new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]));
	_sprScreen.resetFrameBitmapDatas();
	_sprScreen.dirty = true;
	```

That's all there is to it! Our `_sprWaveSprite` will fade in and out with the CombatHUD already. Try our the effect to see how it looks!

![](../images/04_tutorials/0022.png)

You might have noticed, while testing the game, that the mouse cursor can get in the way - especially since it's not needed outside of the menu states. We can remedy this pretty easily.
In the `PlayState.create()`, add:

```haxe
#if !FLX_NO_MOUSE
FlxG.mouse.visible = false;
#end
```

And be sure to do the reverse (`= true`) in `GameOverState.create()` No more pesky mouse cursor when we don't need it!

There are plenty of other tweaks and tricks you can add to your games. I've shown you just a couple. Try playing around with the different addons special effects classes in HaxeFlixel and see what else you can come up with. Take a look at [the demos](http://haxeflixel.com/demos/) for more examples.
