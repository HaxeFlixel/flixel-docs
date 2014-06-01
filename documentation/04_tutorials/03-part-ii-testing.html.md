```
title: "Part II: Testing with a New Project"
```

<p>Now we want to make sure that everything is installed properly - and we want to set up the framework for our game. So we're going to make a new project, open it with FlashDevelop and test that it builds and runs.</p>

<ol>
	<li>
		<p>From the Command Prompt, enter:</p>
		<p><pre><code class="bash">flixel tpl -n "FlixelTut"</code></pre></p>
		<p>This will create a new Flixel project using the blank template in the directory FlixelTut (also naming the project FlixelTut).</p>
	</li>
	<li>
		<p>Outside of the Command Prompt, launch FlashDevelop. Select File>Open and browse to where your FlixelTut directory was created. It should look something like this:</p>
		<p><img src="/images/tutorial/0001.png"/></p>
	</li>
	<li>
		<p>Open the FlixelTut.hxproj file.</p>
	</li>
	<li>
		<p>Over on the right side of the screen, you should see your Project. This will contain all the files that the Template generated for us.</p>
		<p><img src="/images/tutorial/0002.png" /></p>
	</li>
	<li>
		<p>Next, let's make sure that our project builds and runs properly. By default, a fresh, new Flixel Template Project will launch the game in the MenuState. So go ahead and double-click to open that file from the project list.</p>
		<p>This file is a very basic (and empty) example of a FlxState Class. You can think of FlxStates a little bit like 'scenes'. When your game is running, one - and only one - state will be the active state. Anything "added" to that state will be visible and accessible by the player, and, for the most part, will be segregated from other States in your game.</p>
		<p>They are great for having different sections of your game that are sort of in a bubble from one another, such as the MenuState and the PlayState (where the game is actually played).</p>
		<p>You'll see that, at least for now, the MenuState only has 3 functions in it: create, destroy, and update.</p>
		<p>When a State is loaded, its create function is called. This is where you want to initialize all of the things in your state. On the flip side, destroy is called when the state is being unloaded (like when you're switching to a different state). This is where you want to put all your 'clean up' logic.</p>
		<p>Finally update is where all the real magic happens - update is called every "frame" in your game (usually 60 times per second). When a FlxState's update is called, it will call update on all of the objects that have been added to it. This is basically how everything in your game actually happens. We will get to play with this more later on.</p>
		<p>For now, we JUST want to see that the whole thing works, so, we're going to add a simple FlxText object to this state.</p>
	</li>
	<li>
		<p>In the create function, right before the line that says `super.create();`, add a new line and type the following:</p>
		<p><pre><code class="haxe">add(new FlxText(10, 10, 100, "Hello, World!"));</code></pre></p>
		<p>Then save your changes.</p>
	</li>
	<li>
		<p>The Moment of Truth! Go up to the toolbar in FlashDevelop and choose 'Debug' and 'Flash':</p>
		<p><img src="/images/tutorial/0002b.png" /></p>
		<p>Then, press the blue arrow next to 'Debug' (or hit F5) and you should see:</p>
		<p><img src="/images/tutorial/0003.png" /></p>
		<p>It worked! You've built and run your first HaxeFlixel code!</p>
	</li>
</ol>

<p>At this point, you could try running it for neko, windows, and android to make sure they all work as well if you like. If you run into problems with any of those, double-check your code, check out the OpenFL installation information, and if that doesn't help, let us know on the forums.</p>

<p>This is only a small step towards bigger and better things! In the next part, we'll actually define the game we're going to be building, and start putting it together!</p>
