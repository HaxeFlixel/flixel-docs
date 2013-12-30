```
title: "Hello World Command Line"
```
Hello world is a [common example](http://en.wikipedia.org/wiki/Hello_world_program) of getting started with programming, here we will show you how to add Hello World with HaxeFlixel's `FlxText`. You can compile this test for any supported target platform.

Using the command line with HaxeFlixel is made easier with our custom built flixel-tools utility, also made with Haxe.

## Installation of flixel-tools

You first need to install and setup flixel-tools - please refer to [this guide](/documentation/flixel-tools/) for doing so.

## Create a new HaxeFlixel Project Template

HaxeFlixel requires a basic structure of files for any project that you can automatically create with the `template` command (`tpl` for short).

``` bash
flixel tpl -n "Hello World"
```

You will now see a new Hello World folder with all the files for your project being created automatically.

## Add the Hello World FlxText

Adding the text is as simple as opening the `MenuState.hx` file in the newly created source folder.

The file will look like this:

``` haxe
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}
```

All you need to do is add the following in the `create()` method just before `super.create()`:

``` haxe
add(new FlxText(0, 0, 100, "Hello World!")); 
```

Save the file and return to your command line window. Now we can compile the project.

Without running the [lime setup](/documentation/install-openfl) commands you can compile to Flash and Neko out of the box.

Test your project from the following commands:

``` bash
lime test flash
lime test neko
```

If you struggled through any part of this tutorial, ask a question on our [forum](/forum) :)

<img src="/images/hello-world.jpg" style="width:100%;" />
