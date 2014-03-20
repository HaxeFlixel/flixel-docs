```
title: "FlxGroup"
```

FlxGroups are an invaluable method of grouping your game objects in Flixel. In fact, there is no way around them, as `FlxState` itself extends `FlxGroup`. 
The use cases for groups are vast: pooling to reuse objects, collision detection and setting up easy ways to access particular collections of objects. A great feature of FlxGroups are their ability to be nested when using collision detection. Doing collisions is also way more efficient than doing it for individual objects.

The API for FlxGroups is similar to other places in Flixel. Here is a basic example using a group to pool bullet objects, represented by a `Bullet` class, holding a maxium of 100 bullets:

``` haxe
var poolSize = 100;
var bullets = new FlxTypedGroup<Bullet>(poolSize);

for (i in 0...poolSize)
{
	bullets.add(new Bullet().kill());
}
```
Note how we did not use a regular `FlxGroup`, but a `FlxTypedGroup<Bullet>()`. This means that this particular group can only store objects that are instances of the `Bullet` class or instances of `Bullet` subclasses. `FlxGroup` itself is nothing but a shortcut for `FlxTypedGroup<FlxBasic>`.

Now, say we want to retrieve bullet instance to use in a shoot method:

``` haxe
var bullet = bullets.recycle(Bullet);
```

If we had used a regular group here, we would have had to `cast` the return value of `recycle()` to a `Bullet`. By using a `FlxTypedGroup<Bullet>`, we have the benefit of type-safety.

#### add(Object:T):T;

You can add any type of Object that extends the base FlxGroup type, if you use `FlxGroup` this is `FlxBasic`.

#### remove(Object:T):T

Removes an object from a group, it will return the object you removed.

#### getFirstAvailable(ObjectClass:Class&lt;T&gt; = null):T

This will let you get the first FlxBasic class that has exists == true, this is typically used in object pooling when object may have used the kill() method. Note if you destory() objects they will be made null in the FlxGroup and you wont be able to reuse them.

#### kill();

This will recursively kill() all objects so that they will be ready for use with getFirstAvailable.

#### callAll(FunctionName:String, Args:Array&lt;Dynamic&gt; = null, Recurse:Bool = true);

Call the specified function on all members of the group.

#### sort(Function:Int->T->T->Int, Order:Int = FlxSort.ASCENDING);

Call this function to sort the group according to a particular value and order. You will need to specificy a sorting function to do so. If you want to sort by something other than y, you will have to write a custom sorting function.



Otherwase, you can just use the pre-made `FlxSort.byY()` like so for Zelda-style-sorting:

```haxe
group.sort(FlxSort.byY);
```


