```
title: "13 - Multiple Platforms"
```

One of the big advantages of using HaxeFlixel is the ability to build your games for multiple platforms. You can build a working HTML5, Windows, Linux, Mac, Android and iOS game - all from the same code! So far, we've been working with HTML5, and, for the most part, you don't have to do too much to get your game working on other platforms - if you test it under Windows right now, it should mostly work just fine (although, without music, which we'll discuss later). However, you might run into some issues if you try to build it for a mobile device - at the very least, you won't be able to play it without a keyboard. We'll focus on Windows and Android in this tutorial and add a few things to make them work better on those platforms.

HaxeFlixel comes equipped with a powerful feature called _conditionals_. By adding some [conditionals](/documentation/haxeflixel-conditionals) to your code, you can make it so that only certain pieces of code will be compiled depending on the conditionals you use. For example, if you are building for Android, which would probably not have a mouse, you could setup a conditional to skip over all mouse-related code. Alternately, you might also add some code to deal with touches, which would only work on mobile platforms, so you would make sure to wrap that logic in conditionals so that it doesn't try to build on Windows or HTML5.

It's not all that complicated. We'll start with something simple: adding the ability to toggle fullscreen mode on Windows.

Let's add a button to the `OptionsState`:

1. When we initialize and interact with our button, we only want to do it on `desktop` platforms. So, at the top of the class, add:

	```haxe
	#if desktop
	var fullscreenButton:FlxButton;
	#end
	```

2. In `create()`, somewhere after we add our `volumeBar` object, add:

	```haxe
	#if desktop
	fullscreenButton = new FlxButton(0, volumeBar.y + volumeBar.height + 8, FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED", clickFullscreen);
	fullscreenButton.screenCenter(X);
	add(fullscreenButton);
	#end
	```

3. Then we need to add our callback function for that button:

	```haxe
	#if desktop
	function clickFullscreen()
	{
		FlxG.fullscreen = !FlxG.fullscreen;
		fullscreenButton.text = FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED";
		save.data.fullscreen = FlxG.fullscreen;
	}
	#end
	```

	Yes, we wrap the entire function in our conditional - if we're not building for `desktop`, this function will not exist. You'll also notice that we are saving the value of `FlxG.fullscreen` - this will be used to 'remember' the game's screen state when they next launch the game.

4. Next, let's change around our `Main.hx` so that when the game starts it will launch into whatever state the game was last in - fullscreen or not. We need to move things around a little, since we need to find out if we're going into fullscreen or not BEFORE we call `new FlxGame()`, but we need to set the volume AFTER, so `new()` should look like this:

	```haxe
	var startFullscreen:Bool = false;
	var save:FlxSave = new FlxSave();
	save.bind("TurnBasedRPG");
	#if desktop
	if (save.data.fullscreen != null)
	{
		startFullscreen = save.data.fullscreen;
	}
	#end
	
	super();
	addChild(new FlxGame(320, 240, MenuState, 1, 60, 60, false, startFullscreen));
	
	if (save.data.volume != null)
	{
		FlxG.sound.volume = save.data.volume;
	}
	save.close();
	```

5. Next, we need to give players a way to exit the game if they're in fullscreen mode - since they won't easily have access to the close-button anymore.
We do that by adding a new button to the `MenuState`:

	```haxe
	#if desktop
	var exitButton:FlxButton;
	#end
	```

	And in `create()`:

	```haxe
	#if desktop
	exitButton = new FlxButton(FlxG.width - 28, 8, "X", clickExit);
	exitButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
	add(exitButton);
	#end
	```

	Then our callback function just looks like:

	```haxe
	#if desktop
	function clickExit()
	{
		System.exit(0);
	}
	#end
	```

There you go! Now try it out on both HTML5 and Windows targets and notice the differences - you can't go fullscreen in HTML5, and you can in Windows. You also get the button to exit the game on the MenuState while on Windows.

To make our game work with Android, we have to make a few more changes. First, we need to make sure that our `Project.xml` is setup correctly so that our settings are right for Android.

1. In your app tag, at the very top of the file, add this attribute:

	```xml
	package="com.haxeflixel.turnBasedRPG"
	```

	This will give your app a package name to be used on the Android device - it's best to be as unique as possible.

2. You might be wondering how we're going to allow the user to move around in our game on a device without the keyboard or mouse. Well, HaxeFlixel comes with a `FlxVirtualPad` class which we can use to accept touch input from the user and translate it into movement. Head over to `PlayState.hx`:

	Define:
	
	```haxe
	#if mobile
	public static var virtualPad:FlxVirtualPad;
	#end
	```
	
	Create and add (in create):

	```haxe
	#if mobile
	virtualPad = new FlxVirtualPad(FULL, NONE);
	add(virtualPad);
	#end
	```

3. Since the player can't move while they're in combat, we're going to remove the distraction of our virtual pad while combat is happening. In the `startCombat()` function, add:

	```haxe
	#if mobile
	virtualPad.visible = false;
	#end
	```

	And, to make it reappear, in `update()`, somewhere around where we set `inCombat` to `false`, add:

	```haxe
	#if mobile
	virtualPad.visible = true;
	#end
	```

4. The only place where we actually check for button presses is in our `Player` class, in the `updateMovement()` function. We currently have a section of code that is setting different  gs to true based on keyboard input - but since the keyboard might be disabled on some platforms, we need to change that to look like this:

	```haxe
	#if FLX_KEYBOARD
	up = FlxG.keys.anyPressed([UP, W]);
	down = FlxG.keys.anyPressed([DOWN, S]);
	left = FlxG.keys.anyPressed([LEFT, A]);
	right = FlxG.keys.anyPressed([RIGHT, D]);
	#end
	```

5. Right after that logic, we'll add our logic that checks each of the buttons of our virtual pad to see which ones are pressed:

	```haxe
	#if mobile
	var virtualPad = PlayState.virtualPad;
	up = up || virtualPad.buttonUp.pressed;
	down = down || virtualPad.buttonDown.pressed;
	left  = left || virtualPad.buttonLeft.pressed;
	right = right || virtualPad.buttonRight.pressed;
	#end
	```

	Because of the way we've structured our movement logic, we don't need to make any other changes! Getting `up` set to true via keyboard or our virtual pad will do the same thing.

6. Things are a little different for our combat screen. We could setup the virtual pad to work with our combat menu, but that would feel a little clunky, given that the user has the power to tap on whatever they want on the screen. Instead, we're going to utilize touches to figure out what the player wants to do.
	
	This means, in our update function, we need to wrap everything that's currently inside `updateKeyboardInput()` with:

	```haxe
	#if FLX_KEYBOARD
	...
	#end
	```

7. Inside of our `if (!wait)` statement, add:

	```haxe
	updateTouchInput();
	```

	And 

	```haxe
	function updateTouchInput()
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.justReleased())
		{
			for (choice in choices.keys())
			{
				var text = choices[choice];
				if (touch.overlaps(text))
				{
					selectSound.play();
					selected = choice;
					movePointer();
					makeChoice();
					return;
				}
			}
		}
		#end
	}
	```

	What this does is gets a list of all the touches that were just released this update and checks them one at a time to see if any were on top of one of our choices texts. If one of them is, we play our select sound, and act on the selection - ignoring any other touches that might have happened this update.

And that's everything! You should be able to run your game on HTML5, Windows (Neko, too!), and Android and have it work on each with slight variations. And you only have one project and one codebase!

Next we'll polish up our game and add a little juice to make it POP!
