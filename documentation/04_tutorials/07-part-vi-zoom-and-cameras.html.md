```
title: "Part VI: Zoom and Cameras"
```

When you run your game now, you'll notice that everything is really, really small. We're going to make it more visible by applying some zoom to our game so that we can get a better look at the action. This is a pretty quick change:

1. Open the `Main.hx` file. This class initializes your game, and there are a few things here that you could play with, if you want. We just need to change a couple of the parameters.

2. Change the widht and height parameters of `new FlxGame` to `320` and `240` (half of their original values).

3. If you ran the game right now, everything would be zoomed in, but the player would run off the screen pretty quick - we need to tell the camera to follow the player around. So, open the `PlayState` again.

4. In the create function, after you add the player and before `super.create()`, add:
	
	```haxe
	FlxG.camera.follow(_player, TOPDOWN, 1);
	```

	This simply tells the camera to follow the player using the Topdown style, with a lerp of 1 (which helps the camera move a little smoother).

That's it! Test out the game and see how it looks!

![](../images/04_tutorials/0013c.png)

Next, let's give the player something to pickup around the map!
