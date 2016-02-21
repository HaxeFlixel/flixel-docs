```
title: "10 - UI and Combat"
```

Now we want to show the player what's going on. So we need to have some kind of HUD on the screen to tell them what their current/max health is, and how many coins they have. For the health icon you can use this image ![](https://raw.githubusercontent.com/HaxeFlixel/flixel-demos/master/Tutorials/TurnBasedRPG/assets/images/health.png), or make your own. Make sure you save this in `assets/images`.

1. We'll start by making a new `HUD` class which will hold all our HUD elements:

	```haxe
	package;

	import flixel.FlxBasic;
	import flixel.FlxG;
	import flixel.FlxSprite;
	import flixel.group.FlxTypedGroup;
	import flixel.text.FlxText;
	import flixel.util.FlxColor;
	using flixel.util.FlxSpriteUtil;

	class HUD extends FlxTypedGroup<FlxSprite>
	{
		private var _sprBack:FlxSprite;
		private var _txtHealth:FlxText;
		private var _txtMoney:FlxText;
		private var _sprHealth:FlxSprite;
		private var _sprMoney:FlxSprite;

		public function new()
		{
			super();
			_sprBack = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
			_sprBack.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
			_txtHealth = new FlxText(16, 2, 0, "3 / 3", 8);
			_txtHealth.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
			_txtMoney = new FlxText(0, 2, 0, "0", 8);
			_txtMoney.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
			_sprHealth = new FlxSprite(4, _txtHealth.y + (_txtHealth.height/2)  - 4, AssetPaths.health__png);
			_sprMoney = new FlxSprite(FlxG.width - 12, _txtMoney.y + (_txtMoney.height/2)  - 4, AssetPaths.coin__png);
			_txtMoney.alignment = RIGHT;
			_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
			add(_sprBack);
			add(_sprHealth);
			add(_sprMoney);
			add(_txtHealth);
			add(_txtMoney);
			forEach(function(spr:FlxSprite)
			{
				spr.scrollFactor.set(0, 0);
			});
		}

		public function updateHUD(Health:Int = 0, Money:Int = 0):Void
		{
			_txtHealth.text = Std.string(Health) + " / 3";
			_txtMoney.text = Std.string(Money);
			_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
		}
	}
	```

	This class extends `FlxTypedGroup<FlxSprite>` so that it can hold all of our `FlxSprite` objects. It is composed of 5 different items: a background (black, with a 1-pixel thick white line along the bottom), 2 `FlxText` objects: 1 for health, and 1 for money, and two `FlxSprite` objects, for the icons to go next to the `FlxText` objects. At the end of our constructor, we have a `forEach()` call - we use this to iterate through each of the items in this group, and it just sets their `scrollFactor.x` and `scrollFactor.y` to 0, meaning, even if the camera scrolls, all of these items will stay at the same position relative to the screen.

	Finally, we have a function that we can call from anywhere to tell the `HUD` what it should display.

2. Now let's get it to work and have it update whenever we pick up a coin. In your `PlayState`, add this to the top of the class:

	```haxe
	private var _hud:HUD;
	private var _money:Int = 0;
	private var _health:Int = 3;
	```

3. In `create()`, before `super.create()`, add:

	```haxe
	_hud = new HUD();
	add(_hud);
	```

4. Finally, in the `playerTouchCoin()` function we added earlier, somewhere inside the `if`-statement, add:

	```haxe
	_money++;
	_hud.updateHUD(_health, _money);
	```

Go ahead and test out your game, and the HUD should update each time you pick up a coin!

![](../images/01_tutorial/0019.png)

If we had a way to 'hurt' the player, we could also update the health on the HUD… but in order to do that, we need to figure out how we're going to do combat!

Let's begin by establishing what we want our combat system to achieve. First, we're not going to be making the next Final Fantasy game here, this is just a basic demonstration to show how a few different elements can work. So, I think all we want to do is have a simple interface that appears when the player touches an enemy that shows the player's health, and the enemy's health (in a health bar, for obfuscation), and gives the player 2 options: `FIGHT` or `FLEE`.

If they choose to fight, we'll roll some random chance checks to see if the player hits the enemy, and if the enemy hits the player - a hit will do 1 damage. Once the enemy dies, we'll continue on. If they choose to flee, we'll do a check to see if they do flee or not - if they do, the interface closes and the enemy will be stunned for a few seconds so the player can move away. If they fail to flee, the enemy will get a free hit against the player. We'll also show the damage and misses on the interface.

This all seems simple enough, but it's actually going to require several components working together to make it work. It's the most complicated piece of our game so far.

1. The first component will be our `CombatHUD` class. This is a pretty big class - it's going to do most of the heavy lifting with our combat logic. You can see the complete class here:

	[CombatHUD.hx](https://github.com/HaxeFlixel/flixel-demos/blob/master/Tutorials/TurnBasedRPG/source/CombatHUD.hx)

	Take some time to read through it to see how it works, then add it to your project. You will need to add a small function to our `Enemy` class as well:

	```haxe
	public function changeEnemy(EType:Int):Void
	{
	    if (etype != EType)
	    {
	        etype = EType;
	        loadGraphic("assets/images/enemy-" + etype + ".png", true, 16, 16);
	    }
	}
	```

2. Next, we need to get our `CombatHUD` into our `PlayState`. Add this to the top of the `PlayState` class:

	```haxe
	private var _inCombat:Bool = false;
	private var _combatHud:CombatHUD;
	```

3. Move down to `create()`, and, after we add the HUD, and before we call `super.create()`, add:

	```haxe
	_combatHud = new CombatHUD();
	add(_combatHud);
	```

4. Go down to our `update()`, and change it so that we're ONLY checking for collisions and overlaps when we're not in combat. Everything after the `super.update()` should look like this:

	```haxe
	if (!_inCombat)
	{
		FlxG.collide(_player, _mWalls);
		FlxG.overlap(_player, _grpCoins, playerTouchCoin);
		FlxG.collide(_grpEnemies, _mWalls);
		_grpEnemies.forEachAlive(checkEnemyVision);
		FlxG.overlap(_player, _grpEnemies, playerTouchEnemy);
	}
	else
	{
		if (!_combatHud.visible)
		{
			_health = _combatHud.playerHealth;
			_hud.updateHUD(_health, _money);
			if (_combatHud.outcome == VICTORY)
			{
				_combatHud.e.kill();
			}
			else
			{
				_combatHud.e.flicker();
			}
			_inCombat = false;
			_player.active = true;
			_grpEnemies.active = true;
		}
	}
	```

	So, we're adding a check to see if the player touches an enemy. If they do, we'll call a callback to see if we should start combat or not.

	If we're in combat, we're simply going to keep checking to see if the combat HUD is still visible - once it becomes invisible, we know that combat has finished, and we can determine the outcome. If the outcome is `VICTORY` (one of our four enum values), we will kill the enemy, but if the player fled the battle, we will make the enemy flicker, to show that the player is safe from fighting it again for a short amount of time.

5. Next, lets add the functions to handle the player touching an enemy:

	```haxe
	private function playerTouchEnemy(P:Player, E:Enemy):Void
	{
		if (P.alive && P.exists && E.alive && E.exists && !E.isFlickering())
		{
			startCombat(E);
		}
	}

	private function startCombat(E:Enemy):Void
	{
		_inCombat = true;
		_player.active = false;
		_grpEnemies.active = false;
		_combatHud.initCombat(_health, E);
	}
	```

	All we're doing here is verify that both the player and the enemy are alive and exist, as well as that the enemy is not flickering (flickering enemies are those we've just fled from). If so, we start combat.

	The `startCombat()` function simply sets our `inCombat` flag (so we know not to do collisions), and sets the player and all the enemies to inactive, so they no longer update.

	Finally, we call `initCombat()` in our `CombatHUD`, which initializes it and makes it start working.

6. Finally, we want enemies that are flickering to not move - they should act kind of stunned for a second after the enemy flees.

	In the `Enemy` class, under `update()`, add:

	```haxe
	if (isFlickering())
		return;
	```

	At the very top, before doing anything else in that function.

    You will also need to add

	```haxe
	using flixel.util.FlxSpriteUtil;
	```

	to the top of the `Enemy` class.

And that should do it! Test out your game and make sure that it works!

![](../images/01_tutorial/0020.png)

Next, we'll cover winning and losing and setting up all our different states.
