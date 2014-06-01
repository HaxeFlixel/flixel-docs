```
title: "Part XII: Multiple Platforms"
```

<p>One of the big advantages of using HaxeFlixel is the ability to build your games for multiple platforms. You can build a working Flash, Windows, Android, and iOS game - all from the same code! So far, we've been working with Flash, and, for the most part, you don't have to do too much to get your game working on other platforms - if you test it under Windows right now, it should mostly work just fine (although, without music, which we'll discuss later). However, you might run into some issues if you try to build it for a mobile device - at the very least, you won't be able to play it without a keyboard. I will show you some things we can tweak to make it work better on other platforms. We'll focus on Windows and Android, since I have access to those platforms.</p>

<p>HaxeFlixel comes equipped with a powerful feature called conditionals. By adding some <a href="http://haxeflixel.com/documentation/haxeflixel-conditionals/">conditionals</a> to your code, you can make it so that only certain pieces of code will be compiled depending on the conditionals you use. For example, if you are building for Android, which would probably not have a mouse, you could setup a conditional to skip over all mouse-related code. Alternately, you might also add some code to deal with Touches, which would only work on Android, so you would make sure to wrap that logic in conditionals so that it doesn't try to build on Windows or Flash.</p>

<p>It's not all that complicated. We'll start with something simple: adding the ability to toggle Fullscreen mode on Windows.</p>

<p>Let's add a button to the OptionsState:</p>

<ol>
	<li>
		<p>When we initialize and interact with our button, we only want to do it on 'desktop' platforms. So, at the top of the class, add:</p>
		<p><pre><code class="haxe">#if desktop
private var _btnFullScreen:FlxButton;
#end</code></pre></p>
	</li>
	<li>
		<p>In the create function, somewhere after we add our _barVolume object, add:</p>
		<p><pre><code class="haxe">#if desktop
_btnFullScreen = new FlxButton(0, _barVolume.y + _barVolume.height + 8, FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED", clickFullscreen);
_btnFullScreen.screenCenter(true, false);
add(_btnFullScreen);
#end</code></pre></p>
	</li>
	<li>
		<p>Then we need to add our callback function for that button:</p>
		<p><pre><code class="haxe">#if desktop
private function clickFullscreen():Void
{
	FlxG.fullscreen = !FlxG.fullscreen;
	_btnFullScreen.text = FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED";
	_save.data.fullscreen = FlxG.fullscreen;
}
#end</code></pre></p>
		<p>Yes, we wrap the entire function in our conditional - if we're not building for desktop, this function will not exist. You'll also notice that we are saving the value of FlxG.fullscreen - this will be used to 'remember' the game's screen state when they next launch the game.</p>
	</li>
	<li>
		<p>Make sure you clean up you button in destroy:</p>
		<p><pre><code class="haxe">#if desktop
_btnFullScreen = FlxDestroyUtil.destroy(_btnFullScreen);
#end</code></pre></p>
	</li>
	<li>
		<p>Next, let's change around our Main.hx so that when the game starts it will launch into whatever state the game was last in - fullscreen or not. We need to move things around a little, since we need to find out if we're going into fullscreen or not BEFORE we call new FlxGame, but we need to set the volume AFTER, so the section in setupGame should be changed to look like this:</p>
		<p><pre><code class="haxe">var _save:FlxSave = new FlxSave();
_save.bind("flixel-tutorial");
#if desktop
if (_save.data.fullscreen != null)
{
	startFullscreen = _save.data.fullscreen;
}
#end

addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

if (_save.data.volume != null)
{
	FlxG.sound.volume = _save.data.volume;
}
_save.close();</code></pre></p>
	</li>
	<li>
		<p>Next, we need to give players a way to exit the game if they're in Fullscreen mode - since they won't easily have access to the close button anymore.
We do that by adding a new button to the MenuState:</p>
		<p><pre><code class="haxe">#if desktop
private var _btnExit:FlxButton;
#end</code></pre></p>
		<p>And, in create:</p>
		<p><pre><code class="haxe">#if desktop
_btnExit = new FlxButton(FlxG.width - 28, 8, "X", clickExit);
_btnExit.loadGraphic(AssetPaths.button__png, true, 20, 20);
add(_btnExit);
#end</code></pre></p>
		<p>Then our callback function just looks like:</p>
		<p><pre><code class="haxe">#if desktop
private function clickExit():Void
{
	System.exit(0);
}
#end</code></pre></p>
		<p>And, of course, cleanup:</p>
		<p><pre><code class="haxe">#if desktop
_btnExit = FlxDestroyUtil.destroy(_btnExit);
#end</code></pre></p>
	</li>
</ol>

<p>There you go! Now try it out on both Flash and Windows targets and notice the differences - you can't go Fullscreen in Flash, and you can in Windows. You also get the button to exit the game on the MenuState while on Windows.</p>

<p>To make our game work with Android, we have to make a few more changes. First, we need to make sure that our Project.xml is setup correctly so that our settings are right for Android.</p>

<ol>
	<li>
		<p>In your app tag, at the very top of the file, add this attribute:</p>
		<p><pre><code class="xml">package="com.haxeflixel.tutorial"</code></pre></p>
		<p>This will give your app a package name to be used on the Android Device - it's best to be as unique as possible.</p>
	</li>
	<li>
		<p>Next, we need to change our assets around a little bit. Right now, we have &lt;assets path="assets" /&gt; which just says "load all the assets!". We want to filter them out a little bit and only load the ones that we actually NEED. While we're here, we need to make a new version of our music. We need both an mp3 and an ogg version of our music - Flash only allows for mp3 files, however, it is the only platform that can use mp3s (you can read more the reasons why <a href="http://www.openfl.org/blog/2013/09/18/to-mp3-or-not-to-mp3/">here</a>) - besides, ogg is generally a better format to use. You can find free tools on the internet, such as <a href="http://audacity.sourceforge.net/">Audacity</a> to convert your audio file formats if you're not sure how to do that.</p>
		<p>Once you have both versions of your music stored in assets/music, replace your assets tag with:</p>
		<p><pre><code class="xml">&lt;assets path="assets/data" include="*.oel|*.oep" />
&lt;assets path="assets/images" include="*.png" /&gt;
&lt;assets path="assets/sounds" include="*.wav" /&gt;
&lt;assets path="assets/music" include="*.mp3" if="flash" /&gt;
&lt;assets path="assets/music" include="*.ogg" unless="flash" /&gt;</code></pre></p>
		<p>This will simply load the assets from each of our specified folders, grabbing only the files that match the wildcards we've specified. For the music, we load mp3 files if we're building for flash, and ogg if we're building for anything else.</p>
	</li>
	<li>
		<p>Next, we have some definitions that are mostly commented out. Generally, mobile targets won't have access to a keyboard or mouse, and desktop targets won't have access to touch functionality. To make sure our game can handle these platforms properly, we will set some flags based on what target we're building for.</p>
		<p>Look for a section that looks like this and uncomment it (or just add this to your Project.xml):</p>
		<p><pre><code class="xml">&lt;haxedef name="FLX_NO_MOUSE" if="mobile" /&gt;
&lt;haxedef name="FLX_NO_KEYBOARD" if="mobile" /&gt;
&lt;haxedef name="FLX_NO_TOUCH" if="desktop" /&gt;</code></pre></p>
	</li>
	<li>
		<p>The last change to our Project.xml file is to make sure we don't try to use the Debug logic on mobile. At the very bottom of the file, before the closing &lt;/project&gt; tag, add:</p>
		<p><pre><code class="xml">&lt;haxedef name="FLX_NO_DEBUG" if="mobile" /&gt;</code></pre></p>
	</li>
	<li>
		<p>Now that we have different versions of our music, we need to make sure we play the right version. In Main.hx, at the end of setupGame, replace the line where we start playing our music with:</p>
		<p><pre><code class="haxe">#if flash
FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game__mp3, 1, true);
#else
FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game__ogg, 1, true);
#end</code></pre></p>
	</li>
	<li>
		<p>You might be wondering how we're going to allow the user to move around in our game on a device without the keyboard or mouse. Well, HaxeFlixel comes with a VirtualPad object which we can use to accept touch input from the user and translate it into movement. Head over to PlayState.hx:</p>
		<p>Initialize:</p>
		<p><pre><code class="haxe">#if mobile
public static var virtualPad:FlxVirtualPad;
#end</code></pre></p>
		<p>Create and add (in create):</p>
		<p><pre><code class="haxe">#if mobile
virtualPad = new FlxVirtualPad(FULL, NONE);
add(virtualPad);
#end</code></pre></p>
		<p>And cleanup (destroy):</p>
		<p><pre><code class="haxe">#if mobile
virtualPad = FlxDestroyUtil.destroy(virtualPad);
#end</code></pre></p>
	</li>
	<li>
		<p>Since the player can't move while they're in combat, we're going to remove the distraction of our virtual pad while combat is happening. In the startCombat function, add:</p>
		<p><pre><code class="haxe">#if mobile
virtualPad.visible = false;
#end</code></pre></p>
		<p>And, to make it reappear, in update, somewhere around where we set _inCombat to false, add:</p>
		<p><pre><code class="haxe">#if mobile
virtualPad.visible = true;
#end</code></pre></p>
	</li>
	<li>
		<p>The only place where we actually check for button presses is in our Player.hx class, in the updateMovement function. We currently have a section of code that is setting different flags to true based on keyboard input - but since the keyboard might be disabled on some platforms, we need to change that to look like this:</p>
		<p><pre><code class="haxe">#if !FLX_NO_KEYBOARD
_up = FlxG.keys.anyPressed(["UP", "W"]);
_down = FlxG.keys.anyPressed(["DOWN", "S"]);
_left = FlxG.keys.anyPressed(["LEFT", "A"]);
_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
#end</code></pre></p>
	</li>
	<li>
		<p>Right after that logic, we'll add our logic that checks each of the buttons of our Virtual Pad to see which ones are pressed:</p>
		<p><pre><code class="haxe">#if mobile
_up = _up || PlayState.virtualPad.buttonUp.status == FlxButton.PRESSED;
_down = _down || PlayState.virtualPad.buttonDown.status == FlxButton.PRESSED;
_left  = _left || PlayState.virtualPad.buttonLeft.status == FlxButton.PRESSED;
_right = _right || PlayState.virtualPad.buttonRight.status == FlxButton.PRESSED;
#end</code></pre></p>
		<p>Because of the way we've structured our movement logic, we don't need to make any other changes! Getting _up set to true via keyboard or our virtual pad will do the same thing.</p>
	</li>
	<li>
		<p>Things are a little different for our combat screen. We could setup the virtual pad to work with our combat menu, but that would feel a little clunky, given that the user has the power to tap on whatever they want on the screen. Instead, we're going to utilize touches to figure out what the player wants to do.</p>
		<p>This means, in our update function, we need to wrap everything that's currently inside our <code>if (!_wait)</code> statement with:</p>
		<p><pre><code class="haxe">#if !FLX_NO_KEYBOARD</code></pre></p>
	</li>
	<li>
		<p>At the end of our if (!_wait) statement, before the last } we need to add our touch check:</p>
		<p><pre><code class="haxe">#if !FLX_NO_TOUCH
var didSelect:Bool = false;
for (touch in FlxG.touches.justReleased())
{
	if (!didSelect)
	{
		if (touch.overlaps(_choices[0]))
		{
			didSelect = true;
			_sndSelect.play();
			_selected = 0;
			movePointer();
			makeChoice();
		}
		else if (touch.overlaps(_choices[1]))
		{
			didSelect = true;
			_sndSelect.play();
			_selected = 1;
			movePointer();
			makeChoice();
		}
	}
}
#end</code></pre></p>
		<p>What this does is gets a list of all the touches that were just released this update and checks them one at a time to see if any were on top of one of our choices texts. If one of them is, we play our select sound, and act on the selection - ignoring any other touches that might have happened this update.</p>
	</li>
</ol>

<p>And that's everything! You should be able to run your game on Flash, Windows (Neko, too!), and Android and have it work on each with slight variations. And you only have one project and one set of code!</p>

<p><a href="https://github.com/SeiferTim/HaxeFlixel-Tutorial/tree/Part-XII">Here's the latest code</a>, and next we'll polish up our game and add a little juice to make it POP!</p>
