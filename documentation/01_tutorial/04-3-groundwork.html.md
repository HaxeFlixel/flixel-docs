```
title: "3 - Groundwork"
```

Now it's time to think about what we actually want our game to be, and how we're going to pull it off.

The game we're going to help you build will be a very simple top-down 'dungeon crawler' game, where the player controls a single character, moves around a map, fights enemies and collects gold.

So, what does that all actually translate to in HaxeFlixel?

- First, we're going to need to setup our 'world' - this just means we'll need to have a `FlxState` where all the action happens, and figure out what we're going to put in the world.
- For the dungeon itself, it will simply be a `FlxTilemap` - and we'll draw our maps in another tool.
- We will need a `FlxSprite` to represent the player on the screen. This will be the sprite that player will be able to control.
- Enemies will be `FlxSprite`s as well, and we'll have a 'fancy' way to have different types of enemies.
- We'll also need a HUD/Interface for the player to do stuff with and see what's going on. These will be a combination of `FlxGroup`, `FlxSprite`, `FlxText`, `FlxButton` objects and some other things.

We'll tackle each of these things one-by-one.

First up, let's get our player from the `MenuState` to our `PlayState`. Eventually, we'll want a fancy `MenuState` with a button for options, but for right now, we'll just have a button that says "Play" and switches to our `PlayState`.

1. Go ahead and delete the line we added for our "Hello World" test.

	Next, go up to the top of the class - right under where it says:

	```haxe
	class MenuState extends FlxState
	```

	We're going define a new variable. This is where you would define all the variables that you intend to use throughout a given class. We need to define a new `FlxButton` variable to use as our 'play' button. So, type:

	```haxe
	private var _btnPlay:FlxButton;
	```

	Note: if you're using FlashDevelop, it should automatically create an import for `FlxButton` (`import flixel.ui.FlxButton;`) at the top of the class. This should be mostly automatic whenever you use class, but if it doesn't add it for some reason, you can enter it manually, or, highlight `FlxButton` in the editor and hit `Ctrl+Shift+1` to add it.

2. Now, go down to `create()`, and, right before `super.create();`, type:

	```haxe
	_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
	add(_btnPlay);
	```

	This creates a `FlxButton` object and assigns it to the `_btnPlay` variable. We're telling it to make the button at position `(0, 0)` (the top left corner of the screen), to make it say "Play" on it, and to call the function `clickPlay()` when a user clicks the button (we yet have to implement `clickPlay()`).
	Then we add the object to our state so that it can be shown and interacted with.
	Don't worry about the position of the button right now, we're going to move it in a second.

3. Now we need to define our `clickPlay()` function. Somewhere in the class, outside of any existing functions, type:

	```haxe
	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	```

	This function calls `FlxG.switchState()`, which switches the state from whatever the current state is (`MenuState`) to a new instance of `PlayState`.

4. Technically, at this point, the functionality would work - you could run your game and it would do what we want it to do, but we're missing a few things.
	First, we want the button to be in a nicer place. Sure, we could set the x and y coordinates when we create it, but there's a simpler way to do it. Back in `create()`, add a new line somewhere after we create our `FlxButton`, and before `super.create();` (I like to add it before the button is added, but that's just my preference).
	Type:

	```haxe
	_btnPlay.screenCenter();
	```

	`screenCenter()` is a function which takes an object and centers it on the screen either horizontally, vertically or (by default) both. By calling it on our button, the button will be placed in the center of the screen.

8. If you test your game out now, it should go straight to a black screen with our 'Play' button in the middle, and clicking the button will take you to another black screen. If that's what you get, it works! So far, so good!

Next, let's make a simple player sprite that you can move around on the screen.

First, we need to make a new `Player` class. You can think of classes as sort of a functional template. You can use them as-is in a project, but you also have the ability to extend them into new versions. You can kind of think of it as using tracing paper - when you extend a class, you put a new sheet of tracing paper on top - you can still see and use all the stuff in the original class (unless you draw over it), and you can add your own stuff.

We're going to be extending the `FlxSprite` class to create our `Player` class.

1. In the project explorer on the right side of your screen, right-click on your "source" folder, choose "Add" and then "New Class."

	![](../images/01_tutorial/0004.png)

2. In the "New Haxe Class" dialog that pops up, enter "Player" for "Name". Then click the "Browse" button next to "Base Class". Search for `flixel.FlxSprite` and select it.

3. Once your screen looks like this, hit "OK":

	![](../images/01_tutorial/0005.png)

4. You should now see a very basic class which extends `FlxSprite`:

	```haxe
	package;

	import flixel.FlxSprite;
	import flixel.system.FlxAssets.FlxGraphicAsset;

	class Player extends FlxSprite
	{
		public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
		{
			super(X, Y, SimpleGraphic);
		}
	}
	```

	We'll need to fix this up a bit to make it usable.

5. First, lets take out the `SimpleGraphic` argument in the constructor. For our `Player` sprite, we don't need to pass it the graphic.
	So

	```haxe
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	```

	Becomes

	```haxe
	public function new(?X:Float=0, ?Y:Float=0)
	```

	and

	```haxe
	super(X, Y, SimpleGraphic);
	```

	becomes

	```haxe
	super(X, Y);
	```

	With classes, we use the 'super' keyword to refer to the parent class. So, within our `new()` / the constructor, by calling `super(X, Y)` we are basically saying to go up the chain to our parent class, in this case `FlxSprite`, and call its constructor, passing it the `X` and `Y` arguments that were passed to us.

6. Next, we'll want to create a placeholder image to show us where our sprite is, so under `super(X, Y);`, add:

	```haxe
	makeGraphic(16, 16, FlxColor.BLUE);
	```

	(Make sure that an import is created for `FlxColor`, and if it isn't, add it)
	All we're doing here is saying that we want to make this sprite's graphic be a 16x16 pixel blue square.

7. For right now, we just want to get the `Player` class initialized, make sure that it works, and try adding it to our `PlayState`. It's not going to move or do anything yet, that will come in a minute. So save the changes to our `Player` class, and go back to the `PlayState`.
	We need to define our `Player` variable, so underneath the class line, add:

	```haxe
	private var _player:Player;
	```

	And in `create()`, before `super.create();` add:

	```haxe
	_player = new Player(20, 20);
	add(_player);
	```

	This simply assigns a new instance of our `Player` sprite to our `_player` variable, telling it to be placed at `(20, 20)` on the screen, and adds it to our `PlayState`.

8. If you run your project right now, you should see our blue player on the screen!

	![](../images/01_tutorial/0006.png)

	Now let's get it to move around!

So, how do we actually want our player to move around on the screen? Let's support both arrow keys and WASD keys, in 8 directions: up, down, left, right, and diagonally. The player should move at a relatively fixed speed, but have a slight deceleration before stopping to give it just a little bit of 'feeling'.

First, define our player's movement speed and deceleration amounts:

1. In your player class, above the constructor, add:

	```haxe
	public var speed:Float = 200;
	```

	Then, in the constructor, after you call `makeGraphic()`, we need to add some `drag`:

	```haxe
	drag.x = drag.y = 1600;
	```

	`drag`, in HaxeFlixel, is sort of a way to slow down an object when it's not being moved. This will prevent our player sprite from just running forever in the same direction when the user stops pressing any movement keys.
	This is somewhat arbitrary based on what 'feels' right - we can come back and tweak the numbers later on.

2. While there are plenty of ways to handle player movement, it can be simpler to add it to the `Player` class. We'll want to add a new function that will watch for player input and respond to it, so, make a new function:

	```haxe
	private function movement():Void
	{
	}
	```

3. First, inside that new function, we want to define some helper variables so we can easily tell which keys were pressed later on in the function:

	```haxe
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	```

4. Next, we want to actually find out which of these directions the player wants to move in. We'll do that by checking whether certain keys are currently being pressed:

	```haxe
	_up = FlxG.keys.anyPressed([UP, W]);
	_down = FlxG.keys.anyPressed([DOWN, S]);
	_left = FlxG.keys.anyPressed([LEFT, A]);
	_right = FlxG.keys.anyPressed([RIGHT, D]);
	```

	The `anyPressed()` function allows us to ask if any keys out of a list of keys are currently being pressed. You send it an array of keys (their names) and it will return `true` if any of them are pressed. There are a couple of similar functions to check for other key states we might use later on.

5. Next, we want to cancel out opposing directions - if the player is pressing up and down at the same time, we're not going to move anywhere:

	```haxe
	if (_up && _down)
	     _up = _down = false;
	if (_left && _right)
	     _left = _right = false;
	```

6. Next, we'll make sure the player is actually moving:

	```haxe
	if (_up || _down || _left || _right)
	```

7. After that, we need to determine which direction to move the player in, and by how much. A common mistake in games that allow diagonal movement is something like this:

	```haxe
	velocity.x = speed;
	velocity.y = speed;
	```

	While this will, technically, move something diagonally down and right, it will actually move much FASTER than it really should be moving. This is because of [the way triangles work](http://en.wikipedia.org/wiki/Pythagorean_theorem). So, for our player to move, we're not just going to set its `velocity` to `speed` - that would be too easy! Instead, we're going to calculate exactly what its velocity should be with angles!

	The first part of this is to figure out what angle we want to have the player move based on the keys that are being pressed. With our player sprite's asset, angle 0 is to the right, and -90 (or 270) is up.

	```haxe
	var mA:Float = 0;
	if (_up)
	{
		mA = -90;
		if (_left)
			mA -= 45;
		else if (_right)
			mA += 45;
	}
	else if (_down)
	{
		mA = 90;
		if (_left)
			mA += 45;
		else if (_right)
			mA -= 45;
	}
	else if (_left)
		mA = 180;
	else if (_right)
		mA = 0;
	```

	All this will do is create a temporary variable to hold our angle, and then, based on which direction(s) the player is pressing, set that angle to the direction we plan on moving the player.

8. Now that we know which angle the player should be moving in, we need to figure out with how much `velocity` it needs to move that way. We're going to do this by setting `velocity.x` to `speed` and `velocity.y` to `0`. Then we rotate that point around `(0, 0)` by `mA` degrees.

	```haxe
	velocity.set(speed, 0);
	velocity.rotate(FlxPoint.weak(0, 0), mA);
	```

	Next, close the bracket from your `if` statement from earlier.
	...and that's the end of our `movement()` function!

9. The only thing left to do is to `override` the `update()` function in `Player.hx` as well and call `movement()` from it. FlashDevelop can generate the necessary boilerplate code for you, just type `override` and a space, after which a completion popup should appear:

	![](../images/01_tutorial/overrideCompletion.png)

	Select `update` and press enter.

	Now you just need to add the function call, after which it should look like this:

	```haxe
	override public function update(elapsed:Float):Void
	{
		movement();
		super.update(elapsed);
	}
	```

	The `update()` function, as you should remember, is called each 'frame' of the game. So, each time our `PlayState` gets its `update()` called, it calls `update()` on all of its `members`, including the player's `update()`. This in turn will run our `movement()` logic and adjust the player's `velocity` accordingly. After that, it call its `super.update()`, which will take the `velocity` that we've just changed into account and figures out where the player sprite should move to.

Whew! It sounds a lot more complicated than it really is - if you try out the game right now, you'll see that you can run around the screen by pressing any combination of arrow keys and WASD!

Next, we'll work on making the player sprite actually look like something!
