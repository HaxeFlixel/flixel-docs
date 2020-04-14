```
title: "Code Style"
```

This page contains a few notes on HaxeFlixel's code style. Note that we use [haxe-formatter](https://github.com/HaxeCheckstyle/haxe-formatter) to enforce consistent whitespace usage, bracket placement etc, so this page only focuses on naming conventions and other good practices not covered by an auto-formatter.

## Functions

### Function Names

```haxe
function shootEnemy(target:Enemy, bullet:BulletType):Void
```

...is easier to read than

```haxe
function shootAtASpecificEnemyWithABulletTypeOf(target:Enemy, bullet:BulletType):Void
```

...but still gets the idea of what this function does across. The second example has a lot of "noise"-words that don't provide any additional value. The following function name would still be acceptable, more accurate than example 1 even:

```haxe
function shootBulletAtEnemy(target:Enemy, bullet:BulletType):Void
```

However, function names should also not be too short - you should be able to roughly know what a function does simply by reading its name - reading its description, if existent, should ideally not be necessary.

An example for a bad / too simple name would be `shoot()` instead of `shootEnemy()`.

### Parameter Names

Use lowerCamelCases for function parameters and use `this` to explicitly reference to class members (only when necessary):

``` haxe
function translate(words:String, bableFish:BableFish):Void
{
	this.words = words;
}
```

Instead of:

``` haxe
function translate(Words:String, BableFish:BableFish):Void
{
	words = Words;
}
```

In the core of HaxeFlixel, a lot of method parameters are capitalized (not preferred in Haxe). This is mostly legacy from the AS3 Flixel's code style and hard to change them all. However, newly written functions should follow the `lowerCamelCase` style.

## Leveraging Type Inference

The Haxe compiler does not require you to declare the type of a variable ([read more](https://haxe.org/manual/type-system-type-inference.html)).

``` haxe
//This is unnecessary
var name:String = "Merlin";
var number:Int = 32;

//This is preferred
var name = "Merlin";
var number = 32;
```

In some contexts however, doing so improves the readability of the code, for example because it's not immediately obvious what return type a function has:

```haxe
var mystery:Answer = createAnAnswer();
```

## Keyword Order

The original AS3 Flixel codebase ordered keywords like `static public function`.
HaxeFlixel has changed this convention to be more like every other (Haxe) library, the order of importance is as follows:

1. `override`
2. `public` / `private`
3. `static`
4. `inline`

So `static public function` is changed to `public static function`. This also applies to variables eg `public static var`.

## Field Order / Class Outline

The following rules apply, sorted by priority:

1. `static` fields before instance fields
2. `public` fields before `private` fields
3. regular variables before properties
4. getters and setters are the very end of a class (as they should always be private)


## Comments

Comments should only be used when you can't find a way to express the same thing in code. They tend to add noise to the code base and rarely get updated when the code changes, which results in misinformation and inaccurate comments.

Take the following comment section for example, it does not provide *any* additional value beyond what the code and the class / parameter names already tell you (one of the reasons why choosing good names is so important!). It should thus be removed completely.

```haxe
/**
 * Sets the position.
 *
 * @param	x	The x coordinate.
 * @param	y 	The y coordinate.
 */
public function setPosition(x:Int, y:Int):Void
```

## Class Names

All class names should be prefixed by `Flx`, e.g.:

- `FlxBasic`
- `FlxObject`
- `FlxSprite`
- etc..

Even though this is widely regarded as bad style, it still makes sense to follow this convention since it is so deeply ingrained into the flixel workflow and doing otherwise would be very inconsistent and confusing.

This convention does not come without its advantages, for example you can easily tell which classes belong to the engine and which ones don't when writing a game.

## Enum Value Names

The names of enum values are capitalized. The same convention applies to abstract enums.

```haxe
enum FlxCameraFollowStyle
{
	LOCKON;
	PLATFORMER;
	TOPDOWN;
	TOPDOWN_TIGHT;
	SCREEN_BY_SCREEN;
	NO_DEAD_ZONE;
}
```

## Using switch-case as an expression

Unlike in most other languages with object-oriented syntax, everything in Haxe is an expression. This extends to `switch-case`, meaning that it evaluates to a value. This value can be assigned to a variable, passed to a function or simply returned by a function:

```haxe
function getColor(color:Color):Int
{
  return switch (color)
  {
    case Color.RED: 0xff0000;
    case Color.BLUE: 0x0000ff;
    case Color.GREEN: 0x00ff00;
  }
}
```

This is preferable to how this code would look like in a lot of other languages, for example C#:

```csharp
int getColor(Color color) {
  switch (color) {
    case Color.RED:
      return 0xff0000;
    case Color.BLUE:
      return 0x0000ff;
    case Color.GREEN:
      return 0x00ff00;
  }
  return 0x000000;
}
```
