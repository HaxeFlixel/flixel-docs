```
title: "Part V: Tiles, Maps, and Collisions"
```

<p>Now it's time to make some maps for the player to move around in! To do this, we're going to use a tool called Ogmo Editor. Ogmo is a free tile map editor that works very nicely with HaxeFlixel. For this part of the tutorial, we're just going to use a simple 2-tile Tilesheet with a tile for Walls and a tile for Floors.</p>

<p>You can make your own, with 16x16 pixel tiles, or use this one:</p>
<p><a href="https://github.com/HaxeFlixel/flixel-demos/blob/dev/Tutorials/TurnBasedRPG/assets/images/tiles.png"><img src="https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/dev/Tutorials/TurnBasedRPG/
assets/images/tiles.png" /></a></p>
<p>(Note: the first tile should be empty!)</p>

<ol>
	<li>
		<p>Go to <a href="http://www.ogmoeditor.com/">http://www.ogmoeditor.com/</a> to download and install it, then launch the editor.</p>
	</li>
	<li>
		<p>Go to Project > New Project and name your project whatever you want. I would save it under assets/data.</p>
	</li>
	<li>
		<p>Next, you need to define your project's settings. Go through each tab, one-by-one, and set it up to look like the following:</p>
		<p><img src="/images/tutorial/0007.png" /></p>
		<p><img src="/images/tutorial/0008.png" /></p>
		<p><img src="/images/tutorial/0008b.png" /></p>
		<p><img src="/images/tutorial/0009.png" /></p>
		<p><img src="/images/tutorial/0010.png" /></p>
	</li>
	<li>
		<p>Hit Apply to save your changes. You should now see a screen that looks like this:</p>
		<p><img src="/images/tutorial/0011.png" /></p>
	</li>
	<li>
		<p>Make sure you're on the 'walls' layer, and, using tools on the right, draw out a simple map. Make sure it's completely encircled by walls (so the player can't wander off the map), and make the insides filled with floor tiles. You should end up with something like this:</p>
		<p><img src="/images/tutorial/0012.png" /></p>
	</li>
	<li>
		<p>Now, switch over to the 'entities' layer, and place your player entity somewhere in one of your rooms:</p>
		<p><img src="/images/tutorial/0013.png" /></p>
	</li>
	<li>
		<p>Go up to Level > Save Level, and save this as "room-001.oel" in "assets/data".</p>
	</li>
	<li>
		<p>We're done with Ogmo for now, so save all your changes and exit</p>
	</li>
</ol>

<p>One of the great things about using Ogmo with HaxeFlixel is that there is already a class built to load and use the maps, however, it's not in the 'standard' HaxeFlixel library - we have to install the flixel-addons library to get access to it.</p>

<ol>
	<li>
		<p>Open up a new command prompt window, and enter:</p>
		<p><pre><code class="bash">haxelib install flixel-addons</code></pre></p>
		<p>This should run and install the new library. Close the command prompt window when it's finished.</p>
	</li>
	<li>
		<p>Jump back into FlashDevelop and open up your Project.xml file. We need to tell our project to include flixel-addons in the libraries.</p>
	</li>
	<li>
		<p>Look for a line that says:</p>
		<p><pre><code class="xml">&lt;!--&lt;haxelib name="flixel-addons" /&gt;--&gt;</code></pre></p>
		<p>and change it to:</p>
		<p><pre><code class="xml">&lt;haxelib name="flixel-adddons" /&gt;</code></pre></p>
		<p>Save this change. You're now playing with flixel-addons!</p>
	</li>
	<li>
		<p>Go back to your PlayState, and,  underneath where you define your _player object, add:</p>
		<p><pre><code class="haxe">private var _map:FlxOgmoLoader;
private var _mWalls:FlxTilemap;</code></pre></p>
		<p>We're basically just creating an object to hold our Ogmo Map, and then another one to hold the FlxTilemap that we will generate from the Ogmo map.</p>
	</li>
	<li>
		<p>In the create function, before we setup the player object, add:</p>
		<p><pre><code class="haxe">_map = new FlxOgmoLoader(AssetPaths.room_001&#95;&#95;oel);
_mWalls = _map.loadTilemap(AssetPaths.tiles&#95;&#95;png, 16, 16, "walls");
_mWalls.setTileProperties(1, FlxObject.NONE);
_mWalls.setTileProperties(2, FlxObject.ANY);
add(_mWalls);</code></pre></p>
		<p>This just loads our room file into our FlxOgmoLoader object, generates our FlxTilemap from the 'walls' layer, and then sets tile 1 (our floor tile) to not collide, and tile 2 (walls) to collide from any direction. Then we add our tilemap to the state.</p>
	</li>
	<li>
		<p>Now, we need to make our player object get placed in the right location on the map. So, change where we initialize our player from:</p>
		<p><pre><code class="haxe">_player = new Player(20, 20);</code></pre></p>
		<p>to:</p>
		<p><pre><code class="haxe">_player = new Player();
_map.loadEntities(placeEntities, "entities");</code></pre></p>
		<p>We're simply telling our _map object to loop through all of the entities in our 'entities' layer, and call the placeEntities function for each one (which we're about to make now).</p>
	</li>
	<li>
		<p>Let's make the placeEntities function now. When we call loadEntities on our map, it will pass the name of the entity, as well as its Xml data to whatever function we want. In our function, we need to take this information and do something with it. It will look like this now:</p>
		<p><pre><code class="haxe">private function placeEntities(entityName:String, entityData:Xml):Void
{
	var x:Int = Std.parseInt(entityData.get("x"));
	var y:Int = Std.parseInt(entityData.get("y"));
	if (entityName == "player")
	{
		_player.x = x;
		_player.y = y;
	}
}</code></pre></p>
		<p>So, if this function gets passed an entity with the name "player", it will set our player object's x and y values to the Entities x and y values (converting them from Strings to Ints).</p>
	</li>
	<li>
		<p>Now, we want to add collision to our state, so the player will bump into walls instead of just walking through them. So, in our update function, after <code>super.update();</code> add:</p>
		<p><pre><code class="haxe">FlxG.collide(_player, _mWalls);</code></pre></p>
		<p>All this does is check collision between our player and our walls Tilemap each update, and will deal with overlaps accordingly.</p>
	</li>
	<li>
		<p>Finally, we want to make a small tweak to the player sprite. It's a good idea to make sure that your player has a decent chance of making it through doorways. Since, by default, our player sprite is the same size as our tiles (16x16 pixels), it makes it so the player has to thread the needle to make it through 1-tile wide doorways. To remedy this, we're going to change the player sprite's size and offsets. This won't change what is actually displayed for the player's graphic, only the hitbox.</p>
		<p>So, in the Player class, in the constructor, under where we set the drag, add:</p>
		<p><pre><code class="haxe">setSize(8, 14);
offset.set(4, 2);</code></pre></p>
	</li>
	<li>
		<p>Go ahead and run your project, and you should be able to run around the map.</p>
		<p><img src="/images/tutorial/0013b.png" /></p>
	</li>
</ol>

<p>In the next part, we'll talk about some small tweaks to the camera.</p>