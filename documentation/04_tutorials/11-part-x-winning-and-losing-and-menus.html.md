```
title: "Part X:  Winning and Losing and Menus"
```

<p>Our game is really starting to come together! Now we need it to feel more like a 'game' with a win and lose scenario. For our (very simple) game, we'll just make it so that if you ever die in combat, you get a Game Over, and when you beat the boss enemy, you Win. Both of these conditions will take you to the same FlxState to show you your score and allow you to play again if you want.</p>

<ol>
	<li>
		<p>The first thing we want to do is stop our CombatHUD from stopping once the player has been defeated. So in the doneResultsIn function, remove the <code>if (outcome != DEFEAT)</code> statement.</p>
	</li>
	<li>
		<p>We also need to make sure that when our CombatHUD gets destroyed it cleans up all the objects that it has properly. So add this function:</p>
		<p><pre><code class="haxe">override public function destroy():Void
{
	super.destroy();
	e = FlxDestroyUtil.destroy(e);
	_sprBack = FlxDestroyUtil.destroy(_sprBack);
	_sprPlayer = FlxDestroyUtil.destroy(_sprPlayer);
	_sprEnemy = FlxDestroyUtil.destroy(_sprEnemy);
	_enemyHealthBar = FlxDestroyUtil.destroy(_enemyHealthBar);
	_txtPlayerHealth = FlxDestroyUtil.destroy(_txtPlayerHealth);
	_damages = FlxDestroyUtil.destroyArray(_damages);
	_pointer = FlxDestroyUtil.destroy(_pointer);
	_choices = FlxDestroyUtil.destroyArray(_choices);
	_results = FlxDestroyUtil.destroy(_results);
}</code></pre></p>
		<p>It's good practice to get into the habit of destroying all your objects in the destroy function of a class.</p>
	</li>
	<li>
		<p>Now, in PlayState, we need to add some flags to see if we're ending the game, and if the player has 'won' or not. So, add:</p>
		<p><pre><code class="haxe">private var _ending:Bool;
private var _won:Bool;</code></pre></p>
		<p>To the top of the class.</p>
	</li>
	<li>
		<p>Next, in the update function, right under <code>super.update()</code> add:</p>
		<p><pre><code class="haxe">if (_ending)
{
	return;
}</code></pre></p>
		<p>We don't want to allow anything else to go on if we're ending the game and getting ready to switch states.</p>
	</li>
	<li>
		<p>Next, still in update, we're going to change our combatHud logic to this:</p>
		<p><pre><code class="haxe">if (!_combatHud.visible)
{
	_health = _combatHud.playerHealth;
	_hud.updateHUD(_health, _money);
	if (_combatHud.outcome == DEFEAT)
	{
		_ending = true;
		FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
	}
	else
	{
		if (_combatHud.outcome == VICTORY)
		{
			_combatHud.e.kill();
			if (_combatHud.e.etype == 1)
			{
				_won = true;
				_ending = true;
				FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
			}
		}
		else 
		{
			_combatHud.e.flicker();
		}
		_inCombat = false;
		_player.active = true;
		_grpEnemies.active = true;
	}
}</code></pre></p>
		<p>This will now check to see if the outcome was DEFEAT, and if it was, it will set our ending flag to true, and then tell the camera to start fading out - calling doneFadeOut when it's done.</p>
		<p>Similarly, if the outcome was VICTORY, and the enemy that was just defeated was type 1 (the boss), we set our won flag to true, and also start fading out.</p>
	</li>
	<li>
		<p>When the camera is done fading to black, we call this function, which will switch the state to our GameOverState (which you'll make in a second), passing it if the player won or not, and how much money they have.</p>
		<p><pre><code class="haxe">private function doneFadeOut():Void 
{
	FlxG.switchState(new GameOverState(_won, _money));
}</code></pre></p>
	</li>
	<li>
		<p>Make sure we clean up our objects when this state is destroyed (in the destroy function):</p>
		<p><pre><code class="haxe">_player = FlxDestroyUtil.destroy(_player);
_mWalls = FlxDestroyUtil.destroy(_mWalls);
_grpCoins = FlxDestroyUtil.destroy(_grpCoins);
_grpEnemies = FlxDestroyUtil.destroy(_grpEnemies);
_hud = FlxDestroyUtil.destroy(_hud);
_combatHud = FlxDestroyUtil.destroy(_combatHud);</code></pre></p>
	</li>
	<li>
		<p>We need to add the GameOverState. This is going to be a pretty simple FlxState where we show a message - either "Game Over" or "You Win!", depending on our won flag, and the final score for this player. We will also use flixel's save/load functionality to compare the previous hi-scores, and, if the new score is higher, replace the saved hi-score, and show the hi-score on the screen.</p>
		<p>Finally, we have a button to take the player back to the main menu.</p>
		<p>Here is the code for that State:</p>
		<p><a href="https://github.com/SeiferTim/HaxeFlixel-Tutorial/blob/Part-X/source/GameOverState.hx">https://github.com/SeiferTim/HaxeFlixel-Tutorial/blob/Part-X/source/GameOverState.hx</a></p>
	</li>
</ol>

<p>If you test your game, you should be able to trigger the GameOverState by either dying in combat or defeating the boss, and then clicking on the button in the GameOverState will take you back to our MenuState so you can play again. If all of that works, you're on the right track! But… our MenuState is looking a little bland, now… let's fix that up!</p>

<p><img src="/images/tutorial/0021.png" /></p>

<ol>
	<li>
		<p>Let's add a title and an options button to the MenuState:</p>
		<p><pre><code class="haxe">private var _txtTitle:FlxText;
private var _btnOptions:FlxButton;</code></pre></p>
	</li>
	<li>
		<p>Then, in create, we'll add them to the state (and move the Play button, as well):</p>
		<p><pre><code class="haxe">_txtTitle = new FlxText(20, 0, 0, "HaxeFlixel\nTutorial\nGame", 22);
_txtTitle.alignment = "center";
_txtTitle.screenCenter(true, false);
add(_txtTitle);

_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
_btnPlay.x = (FlxG.width / 2) - _btnPlay.width - 10;
_btnPlay.y = FlxG.height - _btnPlay.height - 10;
add(_btnPlay);

_btnOptions = new FlxButton(0, 0, "Options", clickOptions);
_btnOptions.x = (FlxG.width / 2) + 10;
_btnOptions.y = FlxG.height - _btnOptions.height - 10;
add(_btnOptions);</code></pre></p>
	</li>
	<li>
		<p>Add the function that gets called when the options button is clicked:</p>
		<p><pre><code class="haxe">private function clickOptions():Void
{
	FlxG.switchState(new OptionsState());
}</code></pre></p>
	</li>
	<li>
		<p>Then, finally, add some clean-up logic to our destroy function:</p>
		<p><pre><code class="haxe">_txtTitle = FlxDestroyUtil.destroy(_txtTitle);
_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
_btnOptions = FlxDestroyUtil.destroy(_btnOptions);</code></pre></p>
	</li>
	<li>
		<p>The OptionsState that is called from the options button is fairly simple. It will contain a button to allow the user to clear the saved data (hi-scores, etc), as well as a simple FlxBar to show the user the current volume level of the game with buttons to adjust it up or down. It will save the volume values so that each time the game starts, it will 'remember' what volume it was last set to (I know there's no sound…. yet ;) )</p>
		<p>The code for this State looks like this:</p>
		<p><a href="https://github.com/SeiferTim/HaxeFlixel-Tutorial/blob/Part-X/source/OptionsState.hx">https://github.com/SeiferTim/HaxeFlixel-Tutorial/blob/Part-X/source/OptionsState.hx</a></p>
	</li>
	<li>
		<p>Finally, we want our game to load the stored volume (if there is any) each time the game starts, so, goto our Main.hx file, and, in setupGame, after addChild, add:</p>
		<p><pre><code class="haxe">var _save:FlxSave = new FlxSave();
_save.bind("flixel-tutorial");
if (_save.data.volume != null)
{
	FlxG.sound.volume = _save.data.volume;
}
_save.close();</code></pre></p>
		<p>Pretty simple: it makes a new FlxSave object, binds it to our "flixel-tutorial" and then checks if there is a volume value stored in it, and if there is, sets our game's volume to match, and then closes the save.</p>
	</li>
</ol>

<p>Test everything out, make sure it's working, and that if you change your volume under options and then exit the game, it retains the value the next time to get into the options screen.</p>

<p><img src="/images/tutorial/0022.png" /></p>

<p>Looking good! Next time we'll give our volume something to do by adding sound and music!</p>
