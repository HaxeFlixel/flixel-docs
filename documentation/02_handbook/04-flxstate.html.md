---
title: "FlxState"
apiPath: FlxState.html
---

This is the basis for your game's levels and menus, each described in a "state" structure. The state is a way of organising your game objects for the state that the game is currently in. For example, when you create level 0 of your game it's much more organized to only have the code for that level, not every level. Also it's good to use switching states to clear your memory, to avoid memory leaks. A typical Flixel game will have a separate `FlxState` class for every level and menu.

<img src="../images/02_handbook/flixel-state-0.png" width="100%" />

In each `FlxState` all the FlxSprites are added to be rendered.

<img src="../images/02_handbook/flixel-state-1.png" width="100%" />

### Important Methods

#### create()

This is where you setup and create all your state's objects; for example your level tilemaps, your player sprites, spawn your initial enemies. Flixel runs this method before it starts to render your state so its the perfect place.

#### add(object:FlxBasic)

This is the place where you add your sprites, tilemaps etc to your state to be rendered. It works similar to OpenFL's display list API with `addChild()`.

#### remove(object:FlxBasic)

This is the place where you remove sprites etc you have added to your state. Everything you remove still exists so you can add it back later. If you're not going to use the removed object again you might want to consider removing it from memory by setting it as null for example.

#### update(elapsed:Float)

This is the place where you can run code on every frame of your game. It's where you setup your input controls, trigger movement and almost all of your gameplay logic.

``` haxe
package;

import flixel.FlxState;

class FlxExampleState extends FlxState
{
	override public function create():Void
	{
		//create your state objects here
	}

	override public function update(elapsed:Float):Void
	{
		//call super to update the core state class
		super.update(elapsed);
	}
}
```

Here is an example of a simple game state;

``` haxe
package;

import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;

class FlxExampleState extends FlxState
{
	var wizard:FlxSprite;
	var level:FlxTilemap;

	override public function create():Void
	{
		//create a main player
		wizard = new FlxSprite(200, 200, 'assets/player.png');
		wizard.maxVelocity.set(80, 200);
		wizard.acceleration.y = 200; // gravity
		wizard.drag.x = wizard.maxVelocity.x * 4;
		add(wizard);

		//create a tilemap level
		level = new FlxTilemap();
		level.loadMap('assets/level.csv', FlxGraphic.fromClass(GraphicAuto), 0, 0, AUTO);
		add(level);
	}

	override public function update(elapsed:Float):Void
	{
		//control the player with keyboard
		wizard.acceleration.x = 0;

		if (FlxG.keys.pressed.LEFT)
		{
			wizard.acceleration.x = -wizard.maxVelocity.x * 4;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			wizard.acceleration.x = wizard.maxVelocity.x * 4;
		}
		if (FlxG.keys.justPressed.SPACE && wizard.isTouching(FLOOR))
		{
			wizard.velocity.y = -wizard.maxVelocity.y / 2;
		}
		super.update(elapsed);
	}
}
```

 
