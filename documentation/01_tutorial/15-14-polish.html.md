```
title: "14 - Polish"
```

In this section, you're going to learn a few simple tricks to add some polish and juice to your game. Some of those have already been added here and there, but we'll go through a few places now to talk about them.

First up, there's a simple effect we can do with our camera to have it fade in or out. This works nice for transitions between states or screens.
We can add it to each of our states' `create()` function like so (right before `super.create()`):

```haxe
FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
```

Then, if you want to fade out (when switching states), you can do something like this:

```haxe
FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
{
	FlxG.switchState(new PlayState());
});
```

Try adding this logic to all of your states and then see how much of an improvement it gives the flow of your game.

Next, let's give the player a little feedback whenever they get hurt in combat. We're going to make the screen shake briefly. So, go into the `enemyAttack()` function in `CombatHUD` and, right after we call `FlxG.camera.flash` (another neat little effect you can use in other projects), add:

```haxe
FlxG.camera.shake(0.01, 0.2);
```

So, each time the player gets hurt in combat, the screen will flash white, and will shake a little bit for `0.2` seconds. Try it out!

I know we've used tweens a few times already, but lets add one to show the enemy getting hurt in combat. We're simply going to make a tween that moves the enemy a few pixels to the right, then triggers a second tween to move the enemy back - each one taking `0.1` seconds to complete. So, in the `makeChoice()` function of `CombatHUD`, right before we play the hurt sound for the enemy, add:

```haxe
FlxTween.tween(enemySprite, {x: enemySprite.x + 4}, 0.1, {
	onComplete: function(_)
	{
		FlxTween.tween(enemySprite, {x: enemySprite.x - 4}, 0.1);
	}
});
```

Check out how that looks. Tweens are a very simple and powerful tool to make your game feel more active when used properly.

Next, let's add a background effect to our `CombatHUD` to help bring our the combat screen out from the map a little bit. We're going to copy what's on the camera's buffer, desaturate it, and then apply a `FlxWaveEffect` to give it a wavy effect. HaxeFlixel has several effects like this that can be used for a number of effects (`FlxGlitchEffect`, `FlxRainbowEffect`...).

1. Open up the `CombatHUD` class and add this variable:

	```haxe
	var screen:FlxSprite;
	```

2. In the constructor, we'll initialize these two variables (add this before we create our `background`):

	```haxe
	screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
	var waveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 4, -1, 4);
	var waveSprite = new FlxEffectSprite(screen, [waveEffect]);
	add(waveSprite);
	```

	First, we make our `screen`, make it the size of the window, and just leave it empty for now. Then we create a `FlxEffectSprite`, tell it to target our `screen`, and set its properties. It only uses a single effect, our `waveEffect` instance (it's possible to chain multiple effects using `FlxEffectSprite`).

3. Next, in `initCombat` we want to make our `screen` take a copy of whatever is on the camera's buffer and apply it to itself, and then desaturate the image. Our effect sprite will always copy whatever is on our `screen` every update automatically.

	```haxe
	screen.drawFrame();
	var screenPixels = screen.framePixels;
	
	if (FlxG.renderBlit)
		screenPixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
	else
		screenPixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
	
	var rc:Float = 1 / 3;
	var gc:Float = 1 / 2;
	var bc:Float = 1 / 6;
	screenPixels.applyFilter(screenPixels, screenPixels.rect, new Point(), new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]));
	```

That's all there is to it! Our effect sprite will fade in and out with the `CombatHUD` already. Try our the effect to see how it looks!

![](../images/01_tutorial/0022.png)

You might have noticed, while testing the game, that the mouse cursor can get in the way - especially since it's not needed outside of the menu states. We can remedy this pretty easily.
In the `PlayState`'s `create()`, add:

```haxe
#if FLX_MOUSE
FlxG.mouse.visible = false;
#end
```

And be sure to do the reverse (`= true`) in `GameOverState`'s `create()` No more pesky mouse cursor when we don't need it!

There are plenty of other tweaks and tricks you can add to your games. Try playing around with the different addons special effects classes in HaxeFlixel and see what else you can come up with. Take a look at [the demos](/demos/) for more examples.
