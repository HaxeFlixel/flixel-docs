```
title: "9 - Enemies and Basic AI"
```

What would a dungeon game be without enemies? Let's add some!

1. This should be second nature by now - add two new entity types in your Ogmo project, `enemy` and `boss`:

	<img src="../images/01_tutorial/ogmo_project_entities_enemies.png" style="width:100%;" />

2. Then scatter some enemies and a boss around the map.

	<img src="../images/01_tutorial/ogmo_editor_entities_enemies.png" style="width:100%;" />

3. So we want to have 2 different enemies in our game. We'll need spritesheets for both of them, with 16x16 pixel frames and the same animation frames as our player. Name them `enemy-0.png` and `enemy-1.png` and put them in the `assets/images` folder. You can use these, if you want (thanks, again, Vicky!):

	![](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/images/enemy-0.png)

	![](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/images/enemy-1.png)

	Note: make sure that your enemy sprites are functionally the same - they should have the same number of frames for each `facing` animation.

4. Let's add a new `Enemy` class. This class is going to look a lot like our `Player` class, with a few changes:

	```haxe
	class Enemy extends FlxSprite
	{
		public var speed:Float = 140;
		public var etype(default, null):Int;

		public function new(X:Float=0, Y:Float=0, EType:Int)
		{
			super(X, Y);
			etype = EType;
			loadGraphic("assets/images/enemy-" + etype + ".png", true, 16, 16);
			setFacingFlip(FlxObject.LEFT, false, false);
			setFacingFlip(FlxObject.RIGHT, true, false);
			animation.add("d", [0, 1, 0, 2], 6, false);
			animation.add("lr", [3, 4, 3, 5], 6, false);
			animation.add("u", [6, 7, 6, 8], 6, false);
			drag.x = drag.y = 10;
			width = 8;
			height = 14;
			offset.x = 4;
			offset.y = 2;
		}

		override public function draw():Void
		{
			if ((velocity.x != 0 || velocity.y != 0 ) && touching == FlxObject.NONE)
			{
				if (Math.abs(velocity.x) > Math.abs(velocity.y))
				{
					if (velocity.x < 0)
						facing = FlxObject.LEFT;
					else
						facing = FlxObject.RIGHT;
				}
				else
				{
					if (velocity.y < 0)
						facing = FlxObject.UP;
					else
						facing = FlxObject.DOWN;
				}

				switch (facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("lr");

					case FlxObject.UP:
						animation.play("u");

					case FlxObject.DOWN:
						animation.play("d");
				}
			}
			super.draw();
		}
	}
	```

	The main difference is that we have a new `etype` variable, which we will use to figure out which enemy sprite to load, and which one we're dealing with, etc.

5. Next, we'll make a `FlxGroup` in our `PlayState` to hold our enemies, and load them into the map, very much the same way we did our coins.

	At the top of our class, add:

	```haxe
	var _grpEnemies:FlxTypedGroup<Enemy>;
	```

	In the create function, right after we add our coin group:

	```haxe
	_grpEnemies = new FlxTypedGroup<Enemy>();
	add(_grpEnemies);
	```

	and at the end of our if/else statement in `placeEntities()`:

	```haxe
	else if (e.name == "enemy")
	{
		_grpEnemies.add(new Enemy(e.x + 4, e.y, 0));
	}
	else if (e.name == "boss")
	{
		_grpEnemies.add(new Enemy(e.x + 4, e.y, 1));
	}
	```

Go ahead and test out your game to make sure the enemies are added properly.

Now let's give them some brains.

In order to let our enemies 'think', we're going to utilize a very simple [Finite-state Machine (FSM)](http://en.wikipedia.org/wiki/Finite_state_machine). Basically, the FSM works by saying that a given machine (or entity) can only be in one state at a time. For our enemies, we're going to give them 2 possible states: `Idle` and `Chase`. When they can't 'see' the player, they will be `Idle` - wandering around aimlessly. Once the player is in view, however, they will switch to the `Chase` state and run towards the player.

1. Shouldn't be that hard! First, we'll make our `FSM` class:

	```haxe
	class FSM
	{
		public var activeState:Void->Void;

		public function new(?InitState:Void->Void):Void
		{
			activeState = InitState;
		}

		public function update():Void
		{
			if (activeState != null)
				activeState();
		}
	}
	```

2. Next, we'll change our `Enemy` class a little.

	We need to define these variables at the top of the class:

	```haxe
	var _brain:FSM;
	var _idleTmr:Float;
	var _moveDir:Float;
	public var seesPlayer:Bool = false;
	public var playerPos(default, null):FlxPoint;
	```

3. At the end of the constructor, add:

	```haxe
	_brain = new FSM(idle);
	_idleTmr = 0;
	playerPos = FlxPoint.get();
	```

4. And then add the following functions:

	```haxe
	public function idle():Void
	{
		if (seesPlayer)
		{
			_brain.activeState = chase;
		}
		else if (_idleTmr <= 0)
		{
			if (FlxG.random.bool(1))
			{
				_moveDir = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				_moveDir = FlxG.random.int(0, 8) * 45;
				
				velocity.set(speed * 0.5, 0);
				velocity.rotate(FlxPoint.weak(), _moveDir);
				
			}
			_idleTmr = FlxG.random.int(1, 4);			
		}
		else
			_idleTmr -= FlxG.elapsed;
		
	}

	public function chase():Void
	{
		if (!seesPlayer)
		{
			_brain.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
	}

	override public function update(elapsed:Float):Void
	{
	    _brain.update();
	    super.update(elapsed);
	}
	```

	The way this is going to work is that each enemy will start in the `Idle` state. In the `PlayState` we will have each enemy check to see if it can see the player or not. If it can, it will switch to the `Chase` state, until it can't see the player anymore. While in the `Idle` state, every so often (in random intervals) it will choose a random direction to move in for a little while (with a small chance to just stand still). While in the `Chase` state, they will move directly towards the player.

5. Let's jump over to the `PlayState` to add our player's vision logic. In `update()`, under the overlap and collision checks, add:

	```haxe
	FlxG.collide(_grpEnemies, _mWalls);
	_grpEnemies.forEachAlive(checkEnemyVision);
	```

6. Next, add the `checkEnemyVision()` function:

	```haxe
	function checkEnemyVision(e:Enemy):Void
	{
		if (_mWalls.ray(e.getMidpoint(), _player.getMidpoint()))
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(_player.getMidpoint());
		}
		else
			e.seesPlayer = false;
	}
	```

That's all there is to it! Try out your game and make sure it works!

![](../images/01_tutorial/0018b.png)

Next, we'll add some UI to the game, and add our RPG-style combat so you can fight the enemies!
