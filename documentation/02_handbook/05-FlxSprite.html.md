```
title: "FlxSprite"
```

FlxSprites are the core building blocks of all Flixel games. They offer a friendly api to add animation, movement and features for the needs of most games.

It is pretty common place to extend FlxSprite for your own game's needs for example a SpaceShip.hx class may extend FlxSprite but could have additional variables for the game like shield strength or power. When you extend FlxSprite it is important to remember to use super.update() if you override the update method.

```
var player = new FlxSprite();
add(player);
```

#### loadImage()

This method is the easiest way to use a single image for your FlxSprite. Using the OpenFL asset system defined in the project xml file you simply have to define a path to your image and the compiler will do the rest.

```
var player = new FlxSprite();
player.loadImage("assets/player.png");
add(player);
```

#### makeGraphic()

This method is a handy way to make a simple color fill to quickly test a feature or have the basic shape.

```
var whiteSquare = new FlxSprite();
whiteSquare.makeGraphic(200,200,0xffffff);
add(whiteSquare);
```

#### Position

```
whiteSquare.x = 200;
whiteSquare.y = 300;
```

#### ​kill()

This method is useful for when you want to hide a sprite from the stage but keep it available to reuse later. For example you may want to respawn an enemy the player has killed.

#### destroy()

This method is destructive to the sprite and should be used when you want to make sure that the sprite will be cleared from memory. It is commonly used inside a FlxState's overriden destroy method.

### Animation

Flixel supports spritesheet animation.

![](/images/sprite-animation-example.png)

```
player.loadImage("assets/player.png", true, true, 32, 32);
player.animation.add("walk", [0, 1, 2, 3], 5, true);
player.animation.play("walk");

loadImage(file, animated, flip support, frame width, frame height)

animation.add(name, frames, frame rate, looped)
```
