```
title: "Code Style"
```

Over the most recent HaxeFlixel releases, a large amount of the codebase has been modified to follow these style choices.
If you encounter code in the codebase that does not fall under these guidelines, a pull request would be appreciated.

## Functions

### Function names

```haxe
function shootEnemy(Target:Enemy, Bullet:BulletType):Void
```

...is easier to read than

```haxe
function shootAtASpecificEnemyWithABulletTypeOf(Target:Enemy, Bullet:BulletType):Void
```

...but still gets the idea of what this function does across. The second example has a lot of "noise"-words that don't provide any additional value. The following function name would still be acceptable, more accurate than example 1 even:

```haxe
function shootBulletAtEnemy(Target:Enemy, Bullet:BulletType):Void
```

However, function names should also not be too short - you should be able to roughly know what a function does simply by reading its name - reading its description, if existant, should ideally not be necessary. 

An example for a bad / too simple name would be `shoot()` instead of `shootEnemy()` in this example.

### Parameter names

Capitalized letters for function parameters:

``` haxe
function translate(Words:String, Fish:BableFish):Void
```

Instead of:

``` haxe
function translate(words:String, fish:BableFish):Void
```

This is mostly legacy from the AS3 version's code style and hard to change at this point. It creates unique issues that could otherwise be resolved with the `this` keyword for lowercase parameter names:

```haxe
function setPositionFromPoint(Point:FlxPoint):Void
```

Naming the parameter `Point` in this case is problematic because of `flash.geom.Point`. So consistent parameter naming becomes impossible.

## Curley Braces

Use line breaks in methods, operators etc where possible:

``` haxe
function createAwesome(Boring:Stuff, Creative:Things):Void
{
	
}
```

Instead of:

``` haxe
function createAwesome(Boring:Stuff, Creative:Things):Void {
	
}
```

## Private and public variables

An underscore prefix should be used for any private variable:

``` haxe
private var _awesome:Awesome;
```

Do not use a prefix for a public variable:

``` haxe
public var awesome:Awesome;
```

## Leveraging type inference

The Haxe compiler does not require you to declare the type of a variable ([read more](http://haxe.org/ref/type_infer)).

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

## Use of `this`

Using the `this` keyword should never be necessary because function parameters should be capitalized.

``` haxe
//This is unnecessary
if (this.animation.finished)

//This is preferred
if (animation.finished)
```

## Keyword Order

The original AS3 Flixel codebase ordered keywords like `static public function`.
HaxeFlixel has changed this convention to be more like every other (Haxe) library, the order of importance is as follows:

1. `override`
2. `public` / `private`
3. `static`
4. `inline`

So `static public function` is changed to `public static function`. This also applies to variables eg `public static var`.

## Field order / Class outline

The following rules apply, sorted by priority:

1. `static` before regular fields
2. `public` before `private` fields
3. regular variables before properties
4. getter and setter functions are the very end of a class (as they should always be private)


## Comments

Comments should only be used when you can't find a way to express the same thing in code. They tend to add noise to the code base and rarely get updated when the code changes, which results in misinformation and inaccurate comments. 

Take the following comment section for example, it does not provide *any* additional value beyond what the code and the class / parameter names already tell you (one of the reasons why choosing good names is so important!). It should thus be removed completely.

```haxe
/**
 * Sets the position.
 * 
 * @param	X	The x coordinate.
 * @param	Y 	The y coordinate.
 */ 
public function setPosition(X:Int, Y:Int):Void
``` 

## Class names

All class names should be prefixed by `Flx`, e.g.:

- `FlxBasic`
- `FlxObject`
- `FlxSprite`
- etc..

Even though this is widely regarded as bad style, it still makes sense to follow this convention since it is so deeply ingrained into the flixel workflow and doing otherwise would be very inconsistent and confusing. 

This convention does not come without its advantages, for example you can easily tell which classes belong to the engine and which ones don't when writing a game.

## Intendation and Formatting / Tabs and spaces

Tabs should be used for intendation *everywhere*.

However, it is considered preferable to use spaces for formatting since it will look consistent, no matter how your editor is configured. For example, code that looks nice with tab intendation and FlashDevelop's default settings will be a mess on GitHub.

The most common example where formatting is needed are the comment sections for functions:

```haxe
/**
 * Sets the position.
 * 
 * @param   X   The x coordinate.
 * @param   Y   The y coordinate.
 */ 
public function setPosition(X:Int, Y:Int):Void
``` 