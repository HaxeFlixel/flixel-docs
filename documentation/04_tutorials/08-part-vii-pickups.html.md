```
title: "Part VII: Pickups"
```

<p>Now that we have our little guy running around our map, lets give him something to pickup. We'll add some simple coins that will add to the player's score when they are picked up.</p>

<ol>
	<li>
		<p>Open up your project in Ogmo again, and go to Project > Edit Project.</p>
	</li>
	<li>
		<p>On the Entities tab, add a new entity:</p>
		<p><img src="/images/tutorial/0014.png" /></p>
	</li>
	<li>
		<p>Open up the level we used before, and, on the 'entities' layer, scatter a bunch of coins around:</p>
		<p><img src="/images/tutorial/0015.png" /></p>
	</li>
	<li>
		<p>We're going to make our coins be 8x8 pixels. For the coin's graphic, you can use this image <a href="https://raw.githubusercontent.com/SeiferTim/HaxeFlixel-Tutorial/Part-VII/assets/images/coin.png"><img src="https://raw.githubusercontent.com/SeiferTim/HaxeFlixel-Tutorial/Part-VII/assets/images/coin.png" /></a>, or make your own. Make sure you save this in "assets/images".</p>
	</li>
	<li>
		<p>Get back into FlashDevelop, and make a new class:</p>
		<p><img src="/images/tutorial/0016.png" /></p>
	</li>
	<li>
		<p>For now, our coin is going to be really simple. Just change the constructor to look like this:</p>
		<p><pre><code class="haxe">public function new(X:Float=0, Y:Float=0) 
{
	super(X, Y);
	loadGraphic(AssetsPath.coin__png, false, 8, 8);
}</code></pre></p>
	</li>
	<li>
		<p>Now, head back to the PlayState. We need to change our map logic so that when it is loading the entities, when it sees a coin in our Ogmo file, it will add a coin to our state.</p>
	</li>
	<li>
		<p>First, let's make a FlxGroup to hold all the coins in. In the top of our class, where we defined all our variables so far, add:</p>
		<p><pre><code class="haxe">private var _grpCoins:FlxTypedGroup&lt;Coin&gt;;</code></pre></p>
		<p>FlxGroups are like arrays of Flixel Objects which can be used in a lot of different ways. In this case, since our group will only be containing coins, we will make it a FlxTypedGroup.</p>
	</li>
	<li>
		<p>In the create function, after we add our walls, and before we initialize our player, we need to initialize and add our Coin group:</p>
		<p><pre><code class="haxe">_grpCoins = new FlxTypedGroup&lt;Coin&gt;;
add(_grpCoins);</code></pre></p>
	</li>
	<li>
		<p>Next, we just want to change our placeEntities function to put a coin into our group every time it encounters one in our Ogmo file. At the end of our if statement, add:</p>
		<p><pre><code class="haxe">else if (entityName == "coin")
{
	_grpCoins.add(new Coin(x + 4, y + 4));
}</code></pre></p>
		<p>This will simply create a new coin, tell it to be at the position defined in the Ogmo file (+4 x and y to center it on the tile), and add it to the Coin group.</p>
	</li>
	<li>
		<p>Now we need to have the player be able to collect the coins. We're going to use an overlap check to do this. In update, after your FlxG.collide call, add:</p>
		<p><pre><code class="haxe">FlxG.overlap(_player, _grpCoins, playerTouchCoin);</code></pre></p>
		<p>This just says: every update, check if there are any overlaps between the player and the coin group, and if there are, call <code>playerTouchCoin</code>.</p>
	</li>
	<li>
		<p>Let's add the playerTouchCoin callback now:</p>
		<p><pre><code class="haxe">private function playerTouchCoin(P:Player, C:Coin):Void
{
	if (P.alive &amp;&amp; P.exists &amp;&amp; C.alive &amp;&amp; C.exists)
	{
		C.kill();
	}
}</code></pre></p>
		<p>This function simply verifies that the player and the coin that overlap each other are both alive and exist, and if so, kill the coin (we'll add the score a little later on).</p>
		<p>If you run the game right now, as you walk around the map, each coin you touch will disappear. Works great, but it's a little boring… Let's add a little style!</p>
	</li>
	<li>
		<p>Go back to your Coin class, and add these functions:</p>
			<p><pre><code class="haxe">override public function kill():Void
{
	alive = false;
	FlxTween.tween(this, { alpha:0, y:y - 16 }, .33, { ease:FlxEase.circOut, complete:finishKill } );
}

private function finishKill(_):Void
{
	exists = false;
}</code></pre></p>
		<p>First, we override the kill function - normally, by calling kill on an object, it will set both the alive and exists properties to false. In this case, we want to make alive as false, but we don't want to make exists false just yet (objects with exists = false do not get drawn on the screen). Instead, we initialize a FlxTween.</p>
		<p>FlxTween is a powerful tool that lets you animate an object's properties. For our coins, we want to make it fade out while also rising up.</p>
		<p>We set the duration to .33 seconds, and the tween type to ONESHOT so it only happens one time (instead of looping). We are using the 'circOut' easing style, to make it look a little nicer, and we want to call the finishKill function when the Tween has completed, which just sets the coin's exists property to false, removing it from the screen.</p>
		<p>Normally, the FlxTween complete callback will pass the FlxTween, but the "_" parameter in finishKill just allows us to tell our function that we don't care about the parameter being passed to it.</p>
	</li>
</ol>

<p>Try out the game now, and you'll notice the difference when you pick up coins! We'll do some more of this later on when we start adding 'juice' to our game.</p>
<p><img src="/images/tutorial/0016b.png" /></p>

<p>Check out the <a href="https://github.com/SeiferTim/HaxeFlixel-Tutorial/tree/Part-VII">source code</a> for what we've done so far, and in the next part, we'll talk about enemies!</p>
