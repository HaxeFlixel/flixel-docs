```
title: "6 - Loading the Tilemap"
```

One of the great things about using Ogmo with HaxeFlixel is that there is already a built-in class to load and use the maps. However, it's not in the 'standard' HaxeFlixel library - we have to install the flixel-addons library to get access to it.

1. Open up a new command prompt and enter:
	
	```bash
	haxelib install flixel-addons
	```

	This should run and install the new library. Close the command prompt window when it's finished.
	
2. Jump back into FlashDevelop and open up your `Project.xml` file. We need to tell our project to include flixel-addons in the libraries.

3. Look for a line that says:
	
	```xml
	<!--<haxelib name="flixel-addons" />-->
	```
	and change it to:
	
	```xml
	<haxelib name="flixel-addons" />
	```

	Save this change. You're now playing with flixel-addons!

4. Go back to your `PlayState`, and, underneath where the `_player` variable is defined, add:
	
	```haxe
	var _map:FlxOgmoLoader;
	var _mWalls:FlxTilemap;
	```

	We're basically just creating an object to hold our Ogmo map, and then another one to hold the `FlxTilemap` that we will generate from the Ogmo map.

	For Tiled, change `FlxOgmoLoader` to `TiledMap`.

5. In `create()`, before we setup the player object, add:
	
	```haxe
	_map = new FlxOgmoLoader(AssetPaths.room_001__oel);
	_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
	_mWalls.follow();
	_mWalls.setTileProperties(1, FlxObject.NONE);
	_mWalls.setTileProperties(2, FlxObject.ANY);
	add(_mWalls);
	```

	This just loads our room file into our `FlxOgmoLoader` object, generates our `FlxTilemap` from the 'walls' layer, and then sets tile 1 (our floor tile) to not collide, and tile 2 (walls) to collide from any direction. Then we add our tilemap to the state.

	For Tiled, this changes to:

	```haxe
	_map = new TiledMap(AssetPaths.room_001__tmx);
	_mWalls = new FlxTilemap();
	_mWalls.loadMapFromArray(cast(_map.getLayer("walls"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.tiles__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
	_mWalls.follow();
	_mWalls.setTileProperties(2, FlxObject.NONE);
	_mWalls.setTileProperties(3, FlxObject.ANY);
	add(_mWalls);
	```

6. Now, we need to make our player object get placed in the right location on the map. So, change where we initialize our player from:
	
	```haxe
	_player = new Player(20, 20);
	```

	to:

	```haxe
	_player = new Player();
	_map.loadEntities(placeEntities, "entities");
	```

	We're simply telling our `_map` object to loop through all of the entities in our 'entities' layer, and call the `placeEntities()` for each one (which we're about to make now).

    `TiledMap` does not have a built-in `loadEntities()` function, so for that you'll need to change this to:

	```haxe
	var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
	for (e in tmpMap.objects)
	{
		placeEntities(e.name, e.xmlData.x);
	}
	```

7. Let's make the `placeEntities()` function now. When we call `loadEntities()` on our map, it will pass the name of the entity, as well as its XML data to whatever function we want. In our function, we need to take this information and do something with it. It will look like this now:
	
	```haxe
	function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
	}
	```

	So, if this function gets passed an entity with the name "player", it will set our player object's `x` and `y` values to the entity's `x` and `y` values (converting them from `String` to `Int`).

8. Now, we want to add collisions to our state, so the player will bump into walls instead of just walking through them. So, in `update()`, after `super.update(elapsed);` add:

	```haxe
	FlxG.collide(_player, _mWalls);
	```
	
	All this does is check for overlaps between our player and the walls tilemap each `update()` call. If there are any overlaps, the objects are automatically separated from each other.

9. Finally, we want to make a small tweak to the player sprite. It's a good idea to make sure that your player has a decent chance of making it through doorways. Since by default, our player sprite is the same size as our tiles (16x16 pixels), it makes it so the player has to thread the needle to make it through 1-tile wide doorways. To remedy this, we're going to change the player sprite's size and offsets. This won't change what is actually displayed for the player's graphic, only its hitbox.

	So, in the `Player` class, in the constructor, under where we set the `drag`, add:
	
	```haxe
	setSize(8, 14);
	offset.set(4, 2);
	```

10. Go ahead and run your project, and you should be able to run around the map.

	![](../images/01_tutorial/0013b.png)

In the next part, we'll talk about some small tweaks to the camera.
