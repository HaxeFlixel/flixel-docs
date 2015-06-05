```
title: "Part XI: Sound and Music"
```

<p>Our game is really coming together now, but it's still missing something… there's no sound yet!</p>

<p>For this game, we're going to keep is simple (as usual). We're going to have a single, continuously looping track that plays while our game is running. We will also have several, simple sound effects that play for different actions. Playing sounds and music in HaxeFlixel is pretty easy, so this will go quickly!</p>

<p>First, you'll need to make your music and sounds. My friend Patrick Crecelius from <a href="http://fatbard.tumblr.com/">Fat Bard</a> has provided <a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/music/HaxeFlixel_Tutorial_Game.mp3">some music</a> for this tutorial - feel free to use it for this tutorial, or make your own.</p>

<p>I've made a set of sounds, using Bfxr, which you can use if you like, or, make your own!</p>

<p>I've set up 9 sounds to use in our game:</p>

<ul>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/coin.wav">coin.wav</a> - to be used when the player picks up a coin</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/combat.wav">combat.wav</a> - to be used when combat starts</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/fled.wav">fled.wav</a> - will play when the player successfully flees from combat</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/hurt.wav">hurt.wav</a> - will play whenever either the player or the enemy hits with an attack</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/lose.wav">lose.wav</a> - will play when the player dies in combat</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/miss.wav">miss.wav</a> - will play whenever either the player or the enemy misses with an attack</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/select.wav">select.wav</a> - used by buttons and when the player makes a selection</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/step.wav">step.wav</a> - used by the player and the enemies for 'footstep' sounds</p>
	</li>
	<li>
		<p><a href="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/assets/sounds/win.wav">win.wav</a> - used when the player wins in combat</p>
	</li>
</ul>

<p>Once you have your music, place it in "assets/music", and your sound files should go in "assets/sounds"</p>

<p>Now let's change our code to use these sounds:</p>

<ol>
	<li>
		<p>First, open up Main.hx. Since we want our music to start as soon as the game starts, and loop continuously no matter what happens, we're going to make it start playing outside of our states when we setup our game. In the setupGame function, after our volume-setting code, add:</p>
		<p><pre><code class="haxe">FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game&#95;&#95;mp3, 1, true);</code></pre></p>
		<p>Be sure to change the file that you want to play, if your music file is named something different.</p>
	</li>
</ol>

<p>If you try your game out right now, it should play music!</p>

<ol>
	<li>
		<p>Next, we want to make our buttons all make a sound when they get clicked. This is simple, we just tell the button's onUp to load our sound. In MenuState, in create, after you initialize the play button, add this:</p>
		<p><pre><code class="haxe">_btnPlay.onUp.sound = FlxG.sound.load(AssetPaths.select&#95;&#95;wav);</code></pre></p>
	</li>
	<li>
		<p>Now, you can do the same for the options button (changing <code>&#95;btnPlay</code> to <code>&#95;btnOptions</code>), and then for each of the other buttons in our game: 4 of them in OptionsState, and one in GameOverState.</p>
	</li>
	<li>
		<p>Next, let's give our player some footsteps. We don't want to create and destroy a new sound object every time we want to play the same sound, so we will create a FlxSound object to be used over and over. In the top of Player.hx, add:</p>
		<p><pre><code class="haxe">private var &#95;sndStep:FlxSound;</code></pre></p>
	</li>
	<li>
		<p>Then, in the constructor somewhere, we need to load the footstep sound:</p>
		<p><pre><code class="haxe">_sndStep = FlxG.sound.load(AssetPaths.step&#95;&#95;wav);</code></pre></p>
	</li>
	<li>
		<p>Now go to our updateMovement function, and, after we check if the player is moving (<code>if ((velocity.x != 0 || velocity.y != 0) &amp;&amp; touching == FlxObject.NONE)</code>), add:</p>
		<p><pre><code class="haxe">_sndStep.play();</code></pre></p>
		<p>A neat little property of FlxSounds is that if you ever tell one to play, if it's already playing (and you haven't said to 'forceRestart'), it won't play again. This means we can easily call play on our sound every update, and it will sound as if the sound is just being looped - for as long as the player is moving, but will finish if the player has stopped moving, and not start up again while they are stationary.</p>
	</li>
	<li>
		<p>Finish up the player class by destroying and cleaning up our sound in destroy:</p>
		<p><pre><code class="haxe">_sndStep = FlxDestroyUtil.destroy(_sndStep);</code></pre></p>
		<p>You may need to add the destroy function, if you don't have it already.</p>
	</li>
	<li>
		<p>Now, let's give enemies their own footsteps, too. The difference is, instead of just always playing the step sound at full volume, we're going to change the volume based on the proximity of the enemy to the player. This will be easier than it sounds. First, add our sound variable to the top of Enemy.hx:</p>
		<p><pre><code class="haxe">private var _sndStep:FlxSound;</code></pre></p>
	</li>
	<li>
		<p>And then, similarly to how we setup Player.hx, add this to our constructor:</p>
		<p><pre><code class="haxe">_sndStep = FlxG.sound.load(AssetPaths.step&#95;&#95;wav,.4);
_sndStep.proximity(x,y,FlxG.camera.target, FlxG.width *.6);</code></pre></p>
		<p>You'll notice that we are setting the volume to .4 (40%) this is because there will be plenty of enemies in the map, and there footsteps can get kind of annoying and loud. (Besides, they're probably walking around the dungeon barefoot, right?)</p>
		<p>We then setup our proximity for our sounds, setting it's position  to the x and y of this enemy, and telling it to target the FlxG.camera.target object (which happens to be our Player!). Finally, we say that the radius of our footstep sound is a little bit more than half of the screen's width - so we should be able to hear enemies that are just off the screen, and all the enemies' footsteps will sound louder/softer based on their distance from the camera target.</p>
	</li>
	<li>
		<p>Next, in the enemy's update function, after super.update(), we're going to check if the enemy is moving and not bumping into a wall. If they are moving, we set the position of our sound to wherever our enemy is (to the bottom of his sprite - where his feet are), and then play the sound.</p>
		<p><pre><code class="haxe">if ((velocity.x != 0 || velocity.y != 0) &amp;&amp; touching == FlxObject.NONE)
{
	_sndStep.setPosition(x + _halfWidth, y + height);
	_sndStep.play();
}</code></pre></p>
	</li>
	<li>
		<p>Then, make sure you clean up your sound object again (in destroy):</p>
		<p><pre><code class="haxe">_sndStep = FlxDestroyUtil.destroy(_sndStep);</code></pre></p>
	</li>
	<li>
		<p>Next, let's head over to PlayState. We really only need 1 sound to be in the PlayState itself, and that's the one for picking up a coin. While you could put this into the Coin class, because there could be a lot of coins loaded at once, and because we really can't pick up more than one coin at a time (so the sounds don't need to overlap), putting a single coin sound effect in our PlayState saves us a bit of overhead.</p>
		<p>So, just like our other sounds, initialize the variable:</p>
		<p><pre><code class="haxe">private var _sndCoin:FlxSound;</code></pre></p>
		<p>Load the sound (in create):</p>
		<p><pre><code class="haxe">_sndCoin = FlxG.sound.load(AssetPaths.coin&#95;&#95;wav);</code></pre></p>
		<p>Clean it up (in destroy):</p>
		<p><pre><code class="haxe">_sndCoin = FlxDestroyUtil.destroy(_sndCoin);</code></pre></p>
		<p>And, in our playerTouchCoin function, inside of our if statement, add:</p>
		<p><pre><code class="haxe">_sndCoin.play(true);</code></pre></p>
		<p>This time we will use forceReplay so that if the player happens to pickup several coins close to each other the sound will keep up with them.</p>
	</li>
	<li>
		<p>All of the rest of our sounds, because they deal with combat, will be in our CombatHUD class.</p>
		<p>To initialize them:</p>
		<p><pre><code class="haxe">private var _sndFled:FlxSound;
private var _sndHurt:FlxSound;
private var _sndLose:FlxSound;
private var _sndMiss:FlxSound;
private var _sndSelect:FlxSound;
private var _sndWin:FlxSound;
private var _sndCombat:FlxSound;</code></pre></p>
		<p>To load them:</p>
		<p><pre><code class="haxe">_sndFled = FlxG.sound.load(AssetPaths.fled\_\_wav);
_sndHurt = FlxG.sound.load(AssetPaths.hurt&#95;&#95;wav);
_sndLose = FlxG.sound.load(AssetPaths.lose&#95;&#95;wav);
_sndMiss = FlxG.sound.load(AssetPaths.miss&#95;&#95;wav);
_sndSelect = FlxG.sound.load(AssetPaths.select&#95;&#95;wav);
_sndWin = FlxG.sound.load(AssetPaths.win&#95;&#95;wav);
_sndCombat = FlxG.sound.load(AssetPaths.combat&#95;&#95;wav);</code></pre></p>
		<p>and to clean them up:</p>
		<p><pre><code class="haxe">_sndFled = FlxDestroyUtil.destroy(_sndFled);
_sndHurt = FlxDestroyUtil.destroy(_sndHurt);
_sndLose = FlxDestroyUtil.destroy(_sndLose);
_sndMiss = FlxDestroyUtil.destroy(_sndMiss);
_sndSelect = FlxDestroyUtil.destroy(_sndSelect);
_sndWin = FlxDestroyUtil.destroy(_sndWin);
_sndCombat = FlxDestroyUtil.destroy(_sndCombat);</code></pre></p>
		<p>You can probably figure out where they all go, but I'll go through them anyway.</p>
		<p>In initCombat, add:</p>
		<p><pre><code class="haxe">_sndCombat.play();</code></pre></p>
		<p>In finishFadeIn, add:</p>
		<p><pre><code class="haxe">_sndSelect.play();</code></pre></p>
		<p>In update, inside each of our three if statements related to button presses (<code>if (_fire), else if (_up), else if (_down)</code>) add:</p>
		<p><pre><code class="haxe">sndSelect.play();</code></pre></p>
		<p>In makeChoice, in our logic for a 'hit' (after <code>_damages[1].text = "1";</code>), add:</p>
		<p><pre><code class="haxe">_sndHurt.play();</code></pre></p>
		<p>and in our miss logic, add:</p>
		<p><pre><code class="haxe">_sndMiss.play();</code></pre></p>
		<p>Further down, if the player escapes (after <code>outcome = ESCAPE</code>), add:</p>
		<p><pre><code class="haxe">_sndFled.play();</code></pre></p>
		<p>In enemyAttack, if the enemy hits, add:</p>
		<p><pre><code class="haxe">_sndHurt.play();</code></pre></p>
		<p>and if they miss add:</p>
		<p><pre><code class="haxe">_sndMiss.play();</code></pre></p>
		<p>Finally, in doneDamageOut, after <code>outcome = DEFEAT</code>, add:</p>
		<p><pre><code class="haxe">_sndLose.play();</code></pre></p>
		<p>and after outcome = VICTORY, add:</p>
		<p><pre><code class="haxe">_sndWin.play();</code></pre></p>
	</li>
</ol>

<p>And that's it for sound! Play your game now, and you should hear all of the effects we've added (make sure your volume is up high enough, too!) It's starting to look like a real game! Next time, we'll get it working on multiple platforms!</p>
