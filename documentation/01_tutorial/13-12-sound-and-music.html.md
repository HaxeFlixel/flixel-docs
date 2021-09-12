```
title: "12 - Sound and Music"
```

Our game is really coming together now, but it's still missing something… there's no _sound_ yet!

For this game, we're going to keep it simple (as usual). We're going to have a single, continuously looping track that plays while our game is running. We will also have several, simple sound effects that play for different actions. Playing sounds and music in HaxeFlixel is pretty easy, so this will go quickly!

First, you'll need to make your music and sounds. Patrick Crecelius from [Fat Bard](http://fatbard.tumblr.com) has provided [some music](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/music/HaxeFlixel_Tutorial_Game.ogg) for this tutorial - feel free to use it for this tutorial, or make your own.

We've also created some sound effects using [Bfxr](http://www.bfxr.net/), which you can use if you like, or, make your own!

If you've been following along since the UI and Combat section, you already downloaded a few of these, but be sure you have them all.

- [coin.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/coin.wav) - **new!** to be used when the player picks up a coin

- [combat.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/combat.wav) - to be used when combat starts

- [fled.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/fled.wav) - will play when the player successfully flees from combat

- [hurt.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/hurt.wav) - will play whenever either the player or the enemy hits with an attack

- [lose.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/lose.wav) - will play when the player dies in combat

- [miss.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/miss.wav) - will play whenever either the player or the enemy misses with an attack

- [select.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/select.wav) - used by buttons and when the player makes a selection

- [step.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/step.wav) - **new!** used by the player and the enemies for 'footstep' sounds

- [win.wav](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/sounds/win.wav) - used when the player wins in combat

Once you have your music, place it in `assets/music`, and your sound files should go in `assets/sounds`.

Now let's change our code to use these sounds:

1. First, open up `MenuState.hx`. Since we want our music to start as soon as the game starts, and loop continuously no matter what happens, we're going to add this to `create()`.

	```haxe
	if (FlxG.sound.music == null) // don't restart the music if it's already playing
	{
		FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game__ogg, 1, true);
	}
	```

	We're also checking if the music is already playing, since we don't want to restart it unnecessarily in that case.

	If you try your game out right now, it should play music!

2. Next, we want to make our buttons all make a sound when they get clicked. This is simple, we just tell the button's `onUp` to load our sound. In the `MenuState`'s `create()`, after you initialize the play-button, add this:

	```haxe
	playButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
	```

3. Now, you can do the same for the options button (changing `playButton` to `optionsButton`).

	For each of the other buttons in our game - four of them in `OptionsState`, and one in `GameOverState` - the code already exists, but as a learning exercise, you can go through those files and see what was done.

4. Next, let's give our player some footsteps. We don't want to create and destroy a new sound object every time we want to play the same sound, so we will create a `FlxSound` object to be used over and over. At the top of the `Player` class, add:
	
	```haxe
	var stepSound:FlxSound;
	```

5. Then, we need to load the footstep sound somewhere in the constructor:

	```haxe
	stepSound = FlxG.sound.load(AssetPaths.step__wav);
	```

6. Now go to our `updateMovement()` function, and, after we check if the player is moving (`if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)`), add:

	```haxe
	stepSound.play();
	```

	A neat little property of `FlxSound` objects is that if you ever tell one to play, if it's already playing (and you haven't set the `forceRestart` flag), it won't play again. This means we can easily call play on our sound every frame, and it will sound as if the sound is just being looped - for as long as the player is moving, but will finish if the player has stopped moving, and not start up again while they are stationary.

7. Now, let's give enemies their own footsteps, too. The difference is, instead of just always playing the step sound at full volume, we're going to change the volume based on the proximity of the enemy to the player. This will be easier than it sounds. First, add our sound variable to the top of Enemy.hx:

	```haxe
	var stepSound:FlxSound;
	```

8. And then, similarly to how we setup the `Player` class, add this to our constructor:

	```haxe
	stepSound = FlxG.sound.load(AssetPaths.step__wav, 0.4);
	stepSound.proximity(x, y, FlxG.camera.target, FlxG.width * 0.6);
	```

	You'll notice that we are setting the volume to `0.4` (40%) this is because there will be plenty of enemies on the map, and there footsteps can get kind of annoying and loud (besides, they're probably walking around the dungeon barefoot, right?).

9. We then setup our proximity for our sounds, setting it's position  to the `x` and `y` position of this enemy, and telling it to target the `FlxG.camera.target` object (which happens to be our player!). Finally, we say that the radius of our footstep sound is a little bit more than half of the screen's width - so we should be able to hear enemies that are just off the screen, and all the enemies' footsteps will sound louder/softer based on their distance from the camera target.

10. Next, in the enemy's `update()`, before `super.update()`, we're going to check if the enemy is moving and not bumping into a wall. If they are moving, we set the position of our sound to wherever our enemy is (to the bottom of his sprite - where his feet are), and then play the sound.

	```haxe
	if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)
	{
		stepSound.setPosition(x + frameWidth / 2, y + height);
		stepSound.play();
	}
	```

11. Next, let's head over to `PlayState`. We really only need one sound to be in the `PlayState` itself, and that's the one for picking up a coin. While you could put this into the `Coin` class, because there could be a lot of coins loaded at once, and because we really can't pick up more than one coin at a time (so the sounds don't need to overlap), putting a single coin sound effect in our `PlayState` saves us a bit of overhead.

	So, just like our other sounds, initialize the variable:

	```haxe
	var coinSound:FlxSound;
	```

	Load the sound in `create()`:
	
	```haxe
	coinSound = FlxG.sound.load(AssetPaths.coin__wav);
	```

	And in `playerTouchCoin()`, inside the `if`-statement, add:

	```haxe
	coinSound.play(true);
	```

	This time we will use `forceRestart` so that if the player happens to pickup several coins close to each other the sound will keep up with them.

12. All of the rest of our sounds, because they deal with combat, will be in our `CombatHUD` class.

	Assuming you downloaded the `CombatHUD` file, the sounds should already be there, but as a learning exercise, it's a good idea to go through and check. This will help you better understand sounds for when you're working on your next game.

	To initialize them:

	```haxe
	var fledSound:FlxSound;
	var hurtSound:FlxSound;
	var loseSound:FlxSound;
	var missSound:FlxSound;
	var selectSound:FlxSound;
	var winSound:FlxSound;
	var combatSound:FlxSound;
	```

	To load them:

	```haxe
	fledSound = FlxG.sound.load(AssetPaths.fled__wav);
	hurtSound = FlxG.sound.load(AssetPaths.hurt__wav);
	loseSound = FlxG.sound.load(AssetPaths.lose__wav);
	missSound = FlxG.sound.load(AssetPaths.miss__wav);
	selectSound = FlxG.sound.load(AssetPaths.select__wav);
	winSound = FlxG.sound.load(AssetPaths.win__wav);
	combatSound = FlxG.sound.load(AssetPaths.combat__wav);
	```

	You can probably figure out where they all go, but I'll go through them anyway.

	In `initCombat()`:

	```haxe
	combatSound.play();
	```

	In `finishFadeIn()`:

	```haxe
	selectSound.play();
	```

	In `update()`, inside each of our three if statements related to button presses (`if (_fire), else if (up), else if (down)`):

	```haxe
	selectSound.play();
	```

	In `makeChoice()`, in our logic for a 'hit' (after `_damages[1].text = "1";`):

	```haxe
	hurtSound.play();
	```

	and in our miss logic:

	```haxe
	missSound.play();
	```

	Further down, if the player escapes (after `outcome = ESCAPE`):

	```haxe
	fledSound.play();
	```

	In `enemyAttack()`, if the enemy hits:

	```haxe
	hurtSound.play();
	```

	and if they miss:

	```haxe
	missSound.play();
	```

	Finally, in `doneDamageOut()`, after `outcome = DEFEAT`:

	```haxe
	loseSound.play();
	```

	and after `outcome = VICTORY`:
	
	```haxe
	winSound.play();
	```

And that's it for sound! Play your game now, and you should hear all of the effects we've added (make sure your volume is up high enough, too!) It's starting to look like a real game! Next time, we'll get it working on multiple platforms!
