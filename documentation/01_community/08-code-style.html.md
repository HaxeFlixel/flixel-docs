```
title: "Code Style"
```

Over the most recent HaxeFlixel releases, a large amount of the codebase has been modified to follow these style choices.
If you encounter code in the codebase that does not fall under these guidelines, a pull request would be appreciated.

## Functions

### Function names

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

However, function names should also not be too short - you should be able to roughly know what a function does simply by reading its name - reading its description, if existant, should ideally not be necessary. 

An example for a bad / too simple name would be `shoot()` instead of `shootEnemy()` in this example.

### Spacing

The equals sign (`=`) and commas (`,`) in function headers / calls should always be separated by a single space. Spaces should *not* be used after opening and before closing brackets.

| Good                                   | Bad                                    |
| ---------------------------------------| ---------------------------------------|
| `FlxG.resizeGame(320, 240);`           | `FlxG.resizeGame(320,240);`            |
| `function test(value:Int = "5") {}`    | `function test(value:Int="5") {}`      |
| `FlxG.resizeGame(320, 240);`           | `FlxG.resizeGame( 320, 240 );`         |
| `FlxG.resizeGame(320, 240);`           | `FlxG.resizeGame (320, 240);`          |

Spaces *should* be used before the opening brackets of `if`, `for`, `while` and `switch`:

| Good                                   | Bad                                    |
| ---------------------------------------| ---------------------------------------|
| `if (true)`                            | `if(true)`                             |
| `for (element in array)`               | `for(element in array)`                |
| `while (i > 0)`                        | `while(i >0)`                          |
| `switch (variable)`                    | `switch(variable)`                     |

### Parameter names

Use lowerCamelCases for function parameters 
and use `this` to explicitly reference to class members (only when neccessary):

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

In the core of HaxeFlixel, there are a lot of method parameters written in capitalized letters (not preferred in Haxe),
this is mostly legacy from the AS3 Flixel's code style and hard to change them all. However, newly written functions should follow the lowerCamelCases style. Also, we encourge contributors to convert them when fixing bugs/updating existing codes.

## Colon spacing

No extra spaces should be used before and after colons:

| Good                                   | Bad                                    |
| ---------------------------------------| ---------------------------------------|
| var i:Int;                             | var i : Int;                           |
| function toString():String             | function toString() : String           |

## Curly Brackets

Use line breaks in methods, operators etc where possible:

``` haxe
function createAwesome(boring:Stuff, creative:Things):Void
{
	
}
```

Instead of:

``` haxe
function createAwesome(boring:Stuff, creative:Things):Void {
	
}
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

## Class names

All class names should be prefixed by `Flx`, e.g.:

- `FlxBasic`
- `FlxObject`
- `FlxSprite`
- etc..

Even though this is widely regarded as bad style, it still makes sense to follow this convention since it is so deeply ingrained into the flixel workflow and doing otherwise would be very inconsistent and confusing. 

This convention does not come without its advantages, for example you can easily tell which classes belong to the engine and which ones don't when writing a game.

## Indentation and Formatting / Tabs and spaces

Tabs should be used for indentation *everywhere*.

However, it is considered preferable to use spaces for formatting since it will look consistent, no matter how your editor is configured. For example, code that looks nice with tab indentation and FlashDevelop's default settings will be a mess on GitHub.

The most common example where formatting is needed are the comment sections for functions:

```haxe
/**
 * Sets the position.
 * 
 * @param   x   The x coordinate.
 * @param   y   The y coordinate.
 */ 
public function setPosition(x:Int, y:Int):Void
```
 
## Position of metadata

Metadata should always be placed in a new line for increased readability:

```haxe
@:isVar 
@:allow(flixel.tweens.FlxTween)
private static var pool(get, null):FlxPool<MultiVarTween>;
```

as opposed to:

```haxe
@:isVar @:allow(flixel.tweens.FlxTween) private static var pool(get, null):FlxPool<MultiVarTween>;
```
