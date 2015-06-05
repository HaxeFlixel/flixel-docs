```
title: "Part XIII: Polish, finishing up, and juice!"
```

<p>In this section, I'm going to show you a few simple tricks to add some polish and juice to your game. You may have seen me drop a few of these into the code earlier on, but we'll go through a few places now to talk about them.</p>

<p>First up, there's a simple effect we can do with our Camera to have it fade in or out. This works nice for transitions between states or screens.
We can add it to each of our states' create function like so (right before <code>super.create()</code>):</p>
<p><pre><code class="haxe">FlxG.camera.fade(FlxColor.BLACK, .33, true);</code></pre></p>
<p>Then, if you want to fade out (when switching states), you can do something like this:</p>
<p><pre><code class="haxe">FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
	FlxG.switchState(new PlayState());
});</code></pre></p>
<p>Try adding this logic to all of your states and then see how much of an improvement it gives the flow of your game.</p>

<p>Next, let's give the player a little feedback whenever they get hurt in combat. We're going to make the screen shake briefly. So, go into the enemyAttack function in CombatHUD and, right after we call <code>FlxG.camera.flash</code> (another neat little effect you can use in other projects), add:</p>
<p><pre><code class="haxe">FlxG.camera.shake(0.01, 0.2);</code></pre></p>
<p>So, each time the player gets hurt in combat, the screen will flash white, and will shake a little bit for .2 seconds. Try it out!</p>

<p>I know we've used tweens a few times already, but lets add one to show the enemy getting hurt in combat. We're simply going to make a tween that moves the enemy a few pixels to the right, then triggers a second tween to move the enemy back - each one taking .1 seconds to complete. So, in the makeChoice function of CombatHUD, right before we play the hurt sound for the enemy, add:</p>
<p><pre><code class="haxe">FlxTween.tween(&#95;sprEnemy, { x:_sprEnemy.x + 4 }, .1, { complete: function(&#95;) {
	FlxTween.tween(_sprEnemy, { x:_sprEnemy.x - 4 }, .1);
}} );</code></pre></p>
<p>Check out how that looks. Tweens are a very simple and powerful tool to make your game feel more active when used properly.</p>

<p>Next, let's add a background effect to our CombatHUD to help bring our the combat screen out from the map a little bit. We're going to copy what's on the camera's buffer, desaturate it, and then apply a FlxWaveSprite to give it a wavy effect. HaxeFlixel has several addons, like FlxWaveSprite or FlxGlitchSprite that can be used for a number of effects.</p>
<ol>
	<li>
		<p>Open up the CombatHUD class and add these two objects:</p>
		<p><pre><code class="haxe">private var _sprScreen:FlxSprite;
private var _sprWave:FlxWaveSprite;</code></pre></p>
	</li>
	<li>
		<p>In the constructor, we'll initialize these two objects (add this before we create our _sprBack):</p>
		<p><pre><code class="haxe">_sprScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
_sprWave = new FlxWaveSprite(_sprScreen, WaveMode.ALL, 4, -1, 4);
add(_sprWave);</code></pre></p>
		<p>First, we make our <code>_sprScreen</code>, make it the size of the window, and just leave it empty for now. Then we make a FlxWaveSprite, tell it to target our <code>_sprScreen</code>, and set its properties.</p>
	</li>
	<li>
		<p>Next, in <code>initCombat</code>, we want to make our <code>_sprScreen</code> take a copy of whatever is on the camera's buffer and apply it to itself, and then desaturate the image. Our FlxWaveSprite will always copy whatever is on our <code>_sprScreen</code> every update automatically.</p>
		<p><pre><code class="haxe">#if flash
_sprScreen.pixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
_sprScreen.pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
var rc:Float = 1 / 3;
var gc:Float = 1 / 2;
var bc:Float = 1 / 6;
_sprScreen.pixels.applyFilter(_sprScreen.pixels, _sprScreen.pixels.rect, new Point(), new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]));
_sprScreen.resetFrameBitmapDatas();
_sprScreen.dirty = true;</code></pre></p>
	</li>
</ol>

<p>That's all there is to it! Our <code>_sprWaveSprite</code> will fade in and out with the CombatHUD already. Try our the effect to see how it looks!</p>

<p><img src="/images/tutorial/0022.png" /></p>

<p>You might have noticed, while testing the game, that the mouse cursor can get in the way - especially since it's not needed outside of the menu states. We can remedy this pretty easily.</p>
<p>In the <code>PlayState.create()</code>, add:</p>
<p><pre><code class="haxe">#if !FLX_NO_MOUSE
FlxG.mouse.visible = false;
#end</code></pre></p>
<p>And be sure to do the reverse (<code>= true</code>) in <code>GameOverState.create()</code> No more pesky mouse cursor when we don't need it!</p>

<p>There are plenty of other tweaks and tricks you can add to your games. I've shown you just a couple. Try playing around with the different addons special effects classes in HaxeFlixel and see what else you can come up with. Take a look at <a href="http://haxeflixel.com/demos/">the demos</a> for more examples.</p>
