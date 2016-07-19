```
title: "12 - Sound and Music"
```

Our game is really coming together now, but it's still missing something… there's no _sound_ yet!

For this game, we're going to keep it simple (as usual). We're going to have a single, continuously looping track that plays while our game is running. We will also have several, simple sound effects that play for different actions. Playing sounds and music in HaxeFlixel is pretty easy, so this will go quickly!

First, you'll need to make your music and sounds. Patrick Crecelius from [Fat Bard](http://fatbard.tumblr.com) has provided [some music](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/music/HaxeFlixel_Tutorial_Game.mp3) for this tutorial - feel free to use it for this tutorial, or make your own.

We've also created some sound effects using [Bfxr](http://www.bfxr.net/), which you can use if you like, or, make your own!

- [coin.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/coin.wav) - to be used when the player picks up a coin

- [combat.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/combat.wav) - to be used when combat starts

- [fled.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/fled.wav) - will play when the player successfully flees from combat

- [hurt.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/hurt.wav) - will play whenever either the player or the enemy hits with an attack

- [lose.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/lose.wav) - will play when the player dies in combat

- [miss.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/miss.wav) - will play whenever either the player or the enemy misses with an attack

- [select.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/select.wav) - used by buttons and when the player makes a selection

- [step.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/step.wav) - used by the player and the enemies for 'footstep' sounds

- [win.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/win.wav) - used when the player wins in combat

Once you have your music, place it in `assets/music`, and your sound files should go in `assets/sounds`.

Now let's change our code to use these sounds:

1. First, open up `Main.hx`. Since we want our music to start as soon as the game starts, and loop continuously no matter what happens, we're going to make it start playing outside of our states when we setup our game. In the setupGame function, after our volume-setting code, add:

	```haxe
	FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game__mp3, 1, true);
	```

	Be sure to change the file that you want to play, if your music file is named something different.

If you try your game out right now, it should play music!

1. Next, we want to make our buttons all make a sound when they get clicked. This is simple, we just tell the button's `onUp` to load our sound. In the `MenuState`'s `create()`, after you initialize the play-button, add this:

	```haxe
	_btnPlay.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
	```

2. Now, you can do the same for the options button (changing `_btnPlay` to `_btnOptions`), and then for each of the other buttons in our game: four of them in `OptionsState`, and one in `GameOverState`.

3. Next, let's give our player some footsteps. We don't want to create and destroy a new sound object every time we want to play the same sound, so we will create a `FlxSound` object to be used over and over. At the top of the `Player` class, add:
	
	```haxe
	private var _sndStep:FlxSound;
	```

4. Then, we need to load the footstep sound somewhere in the constructor:

	```haxe
	_sndStep = FlxG.sound.load(AssetPaths.step__wav);
	```

5. Now go to our `movement()` function, and, after we check if the player is moving (`if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)`), add:

	```haxe
	_sndStep.play();
	```

	A neat little property of `FlxSound` objects is that if you ever tell one to play, if it's already playing (and you haven't set the `forceRestart` flag), it won't play again. This means we can easily call play on our sound every frame, and it will sound as if the sound is just being looped - for as long as the player is moving, but will finish if the player has stopped moving, and not start up again while they are stationary.

6. Now, let's give enemies their own footsteps, too. The difference is, instead of just always playing the step sound at full volume, we're going to change the volume based on the proximity of the enemy to the player. This will be easier than it sounds. First, add our sound variable to the top of Enemy.hx:

	```haxe
	private var _sndStep:FlxSound;
	```

7. And then, similarly to how we setup the `Player` class, add this to our constructor:

	```haxe
	_sndStep = FlxG.sound.load(AssetPaths.step__wav,.4);
	_sndStep.proximity(x,y,FlxG.camera.target, FlxG.width *.6);
	```

	You'll notice that we are setting the volume to `.4` (40%) this is because there will be plenty of enemies on the map, and there footsteps can get kind of annoying and loud (besides, they're probably walking around the dungeon barefoot, right?).

	We then setup our proximity for our sounds, setting it's position  to the `x` and `y` position of this enemy, and telling it to target the `FlxG.camera.target` object (which happens to be our player!). Finally, we say that the radius of our footstep sound is a little bit more than half of the screen's width - so we should be able to hear enemies that are just off the screen, and all the enemies' footsteps will sound louder/softer based on their distance from the camera target.

8. Next, in the enemy's `update()`, after `super.update()`, we're going to check if the enemy is moving and not bumping into a wall. If they are moving, we set the position of our sound to wherever our enemy is (to the bottom of his sprite - where his feet are), and then play the sound.

	```haxe
	if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
	{
		_sndStep.setPosition(x + _halfWidth, y + height);
		_sndStep.play();
	}
	```

9. Next, let's head over to `PlayState`. We really only need one sound to be in the `PlayState` itself, and that's the one for picking up a coin. While you could put this into the `Coin` class, because there could be a lot of coins loaded at once, and because we really can't pick up more than one coin at a time (so the sounds don't need to overlap), putting a single coin sound effect in our `PlayState` saves us a bit of overhead.

	So, just like our other sounds, initialize the variable:

	```haxe
	private var _sndCoin:FlxSound;
	```

	Load the sound in `create()`:
	
	```haxe
	_sndCoin = FlxG.sound.load(AssetPaths.coin__wav);
	```

	And in `playerTouchCoin()`, inside the `ìf`-statement, add:

	```haxe
	_sndCoin.play(true);
	```

	This time we will use `forceRestart` so that if the player happens to pickup several coins close to each other the sound will keep up with them.

12. All of the rest of our sounds, because they deal with combat, will be in our `CombatHUD` class.

	To initialize them:

	```haxe
	private var _sndFled:FlxSound;
	private var _sndHurt:FlxSound;
	private var _sndLose:FlxSound;
	private var _sndMiss:FlxSound;
	private var _sndSelect:FlxSound;
	private var _sndWin:FlxSound;
	private var _sndCombat:FlxSound;
	```

	To load them:

	```haxe
	_sndFled = FlxG.sound.load(AssetPaths.fled__wav);
	_sndHurt = FlxG.sound.load(AssetPaths.hurt__wav);
	_sndLose = FlxG.sound.load(AssetPaths.lose__wav);
	_sndMiss = FlxG.sound.load(AssetPaths.miss__wav);
	_sndSelect = FlxG.sound.load(AssetPaths.select__wav);
	_sndWin = FlxG.sound.load(AssetPaths.win__wav);
	_sndCombat = FlxG.sound.load(AssetPaths.combat__wav);
	```

	You can probably figure out where they all go, but I'll go through them anyway.

	In initCombat, add:

	```haxe
	_sndCombat.play();
	```

	In finishFadeIn, add:

	```haxe
	_sndSelect.play();
	```

	In `update()`, inside each of our three if statements related to button presses (`if (_fire), else if (_up), else if (_down)`) add:

	```haxe
	sndSelect.play();
	```

	In makeChoice, in our logic for a 'hit' (after `_damages[1].text = "1";`), add:

	```haxe
	_sndHurt.play();
	```

	and in our miss logic, add:

	```haxe
	_sndMiss.play();
	```

	Further down, if the player escapes (after `outcome = ESCAPE`), add:

	```haxe
	_sndFled.play();
	```

	In `enemyAttack()`, if the enemy hits, add:

	```haxe
	_sndHurt.play();
	```

	and if they miss add:

	```haxe
	_sndMiss.play();
	```

	Finally, in `doneDamageOut()`, after `outcome = DEFEAT`, add:

	```haxe
	_sndLose.play();
	```

	and after `outcome = VICTORY`, add:
	
	```haxe
	_sndWin.play();
	```

And that's it for sound! Play your game now, and you should hear all of the effects we've added (make sure your volume is up high enough, too!) It's starting to look like a real game! Next time, we'll get it working on multiple platforms!
