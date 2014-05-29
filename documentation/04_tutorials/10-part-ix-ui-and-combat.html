```
title: "Part IX: UI and Combat"
```

<p>Now we want to show the player what's going on. So we need to have some kind of HUD on the screen to tell them what their current/max health is, and how many coins they have.</p>

<ol>
	<li>
		<p>We'll start by making a new HUD class which will hold all our HUD elements:</p>
		<p><pre><code class="haxe">package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup&lt;FlxSprite&gt;
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
		_txtHealth.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		_txtMoney = new FlxText(0, 2, 0, "0", 8);
		_txtMoney.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		_sprHealth = new FlxSprite(4, _txtHealth.y + (_txtHealth.height/2)  - 4, AssetPaths.health__png);
		_sprMoney = new FlxSprite(FlxG.width - 12, _txtMoney.y + (_txtMoney.height/2)  - 4, AssetPaths.coin__png);
		_txtMoney.alignment = "right";
		_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
		add(_sprBack);
		add(_sprHealth);
		add(_sprMoney);
		add(_txtHealth);
		add(_txtMoney);
		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set();
		});
	}
	
	public function updateHUD(Health:Int = 0, Money:Int = 0):Void
	{
		_txtHealth.text = Std.string(Health) + " / 3";
		_txtMoney.text = Std.string(Money);
		_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
	}
}</code></pre></p>
		<p>This class extends FlxTypedGroup&lt;FlxSprite&gt; so that it can hold all of our FlxSprite objects. It is composed of 5 different items: a background (black, with a 1-pixel thick white line along the bottom), 2 FlxText objects: 1 for Health, and 1 for Money, and 2 FlxSprites, for the icons to go next to the FlxTexts. At the end of our constructor, we have a forEach call - we use this to iterate through each of the items in this group, and it just sets their scrollFactor.x and scrollFactor.y to 0, meaning, even if the camera scrolls, all of these items will stay at the same position relative to the screen.</p>
		<p>Finally, we have a function that we can call from anywhere to tell the HUD what it should display.</p>
	</li>
	<li>
		<p>Now let's get it to work and have it update whenever we pick up a coin.</p>
		<p>In your PlayState, add to the top of the class:</p>
		<p><pre><code class="haxe">private var _hud:HUD;
private var _money:Int = 0;
private var _health:Int = 3;</code></pre></p>
	</li>
	<li>
		<p>In the create function, before super.create(), add:</p>
		<p><pre><code class="haxe">_hud = new HUD();
add(_hud);</code></pre></p>
	</li>
	<li>
		<p>Finally, in the playerTouchCoin function we added earlier, somewhere inside the if statement, add:</p>
		<p><pre><code class="haxe">_money++;
_hud.updateHUD(_health, _money);</code></pre></p>
	</li>
</ol>

<p>Go ahead and test out your game, and the HUD should update each time you pick up a coin!</p>
<p><img src="/images/tutorial/0019.png" /></p>
<p>If we had a way to 'hurt' the player, we could also update the health on the HUD… but in order to do that, we need to figure out how we're going to do combat!</p>

<p>Let's begin by establishing what we want our combat system to achieve. First, we're not going to be making the next Final Fantasy game here, this is just a basic demonstration to show how a few different elements can work. So, I think all we want to do is have a simple interface that appears when the player touches an enemy that shows the Player's health, and the Enemy's health (in a health bar, for obfuscation), and gives the player 2 options: FIGHT or FLEE.</p>

<p>If they choose to fight, we'll roll some random chance checks to see if the player hits the enemy, and if the enemy hits the player - a hit will do 1 damage. Once the enemy dies, we'll continue on. If they choose to flee, we'll do a check to see if they do flee or not - if they do, the interface closes and the enemy will be stunned for a few seconds so the player can move away. If they fail to flee, the enemy will get a free hit against the player. We'll also show the damage and Misses on the interface.</p>

<p>This all seems simple enough, but it's actually going to require several components working together to make it work. It's the most complicated piece of our game so far.</p>

<ol>
	<li>
		<p>The first component will be our CombatHUD class. This is a pretty big class - it's going to do most of the heavy lifting with our combat logic. You can see the complete class here:</p>
		<p><a href="https://github.com/SeiferTim/HaxeFlixel-Tutorial/blob/Part-IX/source/CombatHUD.hx">https://github.com/SeiferTim/HaxeFlixel-Tutorial/blob/Part-IX/source/CombatHUD.hx</a></p>
		<p>Take some time to read through it to see how it works, then add it to your project.</p>
	</li>
	<li>
		<p>Next, we need to get our CombatHUD into our PlayState. Add this to the top of the PlayState Class:</p>
		<p><pre><code class="haxe">private var _inCombat:Bool = false;
private var _combatHud:CombatHUD;</code></pre></p>
	</li>
	<li>
		<p>Move down to the create function, and, after we add the HUD, and before we call super.create, add:</p>
		<p><pre><code class="haxe">_combatHud = new CombatHUD();
add(_combatHud);</code></pre></p>
	</li>
	<li>
		<p>Go down to our update function, and change it so that we're ONLY checking for collision and overlaps and things when we're not in combat. Everything after the super.update should look like this:</p>
		<p><pre><code class="haxe">if (!_inCombat)
{
	FlxG.collide(_player, _mWalls);
	FlxG.overlap(_player, _grpCoins, playerTouchCoin);
	FlxG.collide(_grpEnemies, _mWalls);
	checkEnemyVision();
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
}</code></pre></p>
		<p>So, we're adding a check to see if the player touches an enemy. If they do, we'll call a callback to see if we should start combat or not.</p>
		<p>If we're in combat, we're simply going to keep checking to see if the combatHUD is still visible - once it becomes invisible, we know that combat has finished, and we can determine the outcome. If the outcome is VICTORY (one of our 4 enum values), we will kill the enemy, but if the player Fled the battle, we will make the enemy flicker, to show that the player is safe from fighting it again for a short amount of time.</p>
	</li>
	<li>
		<p>Next, lets add the functions to handle the player touching an enemy:</p>
		<p><pre><code class="haxe">private function playerTouchEnemy(P:Player, E:Enemy):Void
{
	if (P.alive &amp;&amp; P.exists &amp;&amp; E.alive &amp;&amp; E.exists &amp;&amp; !E.isFlickering())
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
}</code></pre></p>
		<p>All we're doing here is checking to see if the player is alive and exists and the enemy is alive and exists and not flickering (flickering enemies are those we've just fled from), and if so, we start combat.</p>
		<p>The startCombat function simply sets our inCombat flag (so we know not to do collisions), and sets the player and all the enemies to inactive, so they no longer update.</p>
		<p>Finally, we call the initCombat function in our CombatHUD, which initializes it and makes it start working.</p>
	</li>
	<li>
		<p>Finally, we want enemies that are flickering to not move - they should act kind of stunned for a second after the enemy flees.</p>
		<p>In the Enemy class, under update, add: </p>
		<p><pre><code class="haxe">if (isFlickering())
	return;</code></pre></p>
		<p>At the very top, before doing anything else in that function.</p>
	</li>
</ol>

<p>And that should do it! Test out your game and make sure that it works!</p>
<p><img src="/images/tutorial/0020.png" /></p>
<p>You can see the <a href="https://github.com/SeiferTim/HaxeFlixel-Tutorial/tree/Part-IX">source here</a> to make sure you're on the same page. Next, we'll cover winning and losing and setting up all our different FlxStates.</p>