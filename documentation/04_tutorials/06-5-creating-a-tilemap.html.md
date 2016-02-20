```
title: "5 - Creating a Tilemap"
```

Now it's time to make some maps for the player to move around in! To do this, we're going to use a tool called Ogmo Editor. Ogmo is a free tile map editor that works very nicely with HaxeFlixel. For this part of the tutorial, we're just going to use a simple 2-tile Tilesheet with a tile for Walls and a tile for Floors.

You can make your own, with 16x16 pixel tiles, or use this one:

![](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/images/tiles.png)

(Note: the first tile should be empty!)

1. Go to [http://www.ogmoeditor.com](http://www.ogmoeditor.com/) to download and install it, then launch the editor.

2. Go to Project > New Project and name your project whatever you want. I would save it under assets/data.

3. Next, you need to define your project's settings. Go through each tab, one-by-one, and set it up to look like the following:

	![](../images/04_tutorials/0007.png)

	![](../images/04_tutorials/0008.png)

	![](../images/04_tutorials/0008b.png)

	![](../images/04_tutorials/0009.png)

	![](../images/04_tutorials/0010.png)

4. Hit Apply to save your changes. You should now see a screen that looks like this:
	
	![](../images/04_tutorials/0011.png)

5. Make sure you're on the 'walls' layer, and, using tools on the right, draw out a simple map. Make sure it's completely encircled by walls (so the player can't wander off the map), and make the insides filled with floor tiles. You should end up with something like this:
	
	![](../images/04_tutorials/0012.png)

6. Now, switch over to the 'entities' layer, and place your player entity somewhere in one of your rooms:
	
	![](../images/04_tutorials/0013.png)

7. Go up to Level > Save Level, and save this as "room-001.oel" in "assets/data".

8. We're done with Ogmo for now, so save all your changes and exit.

In the next part, we will learn how to load the newly created tilemap into our game.