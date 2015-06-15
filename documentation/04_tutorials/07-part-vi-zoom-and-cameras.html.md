```
title: "Part VI: Zoom and Cameras"
```

<p>When you run your game now, you'll notice that everything is really, really small. We're going to make it more visible by applying some zoom to our game so that we can get a better look at the action. This is a pretty quick change:</p>

<ol>
	<li>
		<p>Open the Main.hx file. This class initializes your game, and there are a few things here that you could play with, if you want. We just need to change a couple of the parameters.</p>
	</li>
	<li>
		<p>Change gameWidth and gameHeight to 320 and 240 (half of their original values). You could also change zoom from -1 to 2 if you wanted, but since it's at  -1, it will auto-calculate the zoom based on the difference between your game's size and the window dimension (which is defined in Project.xml).</p>
	</li>
	<li>
		<p>If you ran the game right now, everything would be zoomed in, but the player would run off the screen pretty quick - we need to tell the camera to follow the player around.</p>
		<p>So, open the PlayState again.</p>
	</li>
	<li>
		<p>In the create function, after you add the player and before <code>super.create()</code>, add:</p>
		<p><pre><code class="haxe">FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);</code></pre></p>
		<p>This simply tells the camera to follow the player using the Topdown style, with a lerp of 1 (which helps the camera move a little smoother). Note: we 'skipped' over the offset parameter, this is a neat feature in Haxe which you can read about <a href="http://haxe.org/manual/types-function-optional-arguments.html">here</a> and <a href="http://haxe.org/manual/types-function-default-values.html">here</a>.</p>
	</li>
</ol>

<p>That's it! Test out the game and see how it looks!</p>
<p><img src="../images/04_tutorials/0013c.png" /></p>

<p>Next, let's give the player something to pickup around the map!</p>