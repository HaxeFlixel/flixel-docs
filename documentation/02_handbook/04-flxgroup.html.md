```
title: "FlxGroup"
```

FlxGroups are an invaluable method of grouping your game objects in Flixel. The use cases for this are vast for example, pooling to reuse objects, collision detection and setting up easy ways to access particular collections of objects. A great feature of FlxGroups are their ability to be nested when using collision detection.

The api for FlxGroups is similar to other places in Flixel you can see a basic example adding Bullets to a group.

``` haxe
var bullets = new FlxGroup();
var poolSize = 100;
var i = 0;
while (i < poolSize/2) {
    bullets.add(new Bullet());
    i++;
}
```

To call a bullet to fire at something you can the pool from using getFirstAvailable;

``` haxe
var bullet = bullets.getFirstAvailable(Bullet);
```

#### add(Object:T):T;

You can add any type of Object that extends the base FlxGroup Type, if you use FlxGroup this is FlxBasic.

#### remove(Object:T):T

Removes an object from a group, it will return the object you removed.

#### getFirstAvailable(ObjectClass:Class&lt;T&gt; = null):T

This will let you get the first FlxBasic class that has exists == true, this is typically used in object pooling when object may have used the kill() method. Note if you destory() objects they will be made null in the FlxGroup and you wont be able to reuse them.

#### kill();

This will recursively kill() all objects so that they will be ready for use with getFirstAvailable.