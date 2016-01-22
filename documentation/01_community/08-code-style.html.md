```
title: "Code Style"
```

This is HaxeFlixel's code style. Not the entire codebase conforms for it at the moment, but at least any new code should be written with this in mind.

## Line Breaks

### Before Opening Curly Brackets

There should always be a single line break before an opening curly bracket.

**Good:**

``` haxe
private function example()
{
	while (true)
	{
		trace("looping");
		trace("still looping");
	}
}
```

**Bad:**

``` haxe
private function example() {
	while (true) {
		trace("looping");
		trace("still looping");
	}
}
```

### Omitting Blocks

When the body of an `if`, `else`, `for` or `while` only consists of a single line, omitting the curly brackets is acceptable and often preferable since it drastically reduces the line count.

**Good:**

```haxe
while (true)
	trace("looping");
```

In those cases however, the body should still be in a separate line.

**Bad:**

```haxe
while (true) trace("looping");
```

### Additional Line Breaks

There shouldn't be any additional line breaks right after a `{` or before a `}`.

**Good:**

``` haxe
class Example
{
	public function new()
	{
		super();
	}
}
```

**Bad:**

``` haxe
class Example
{

	public function new()
	{
		super();

	}

}
```

### In Function Bodies

Using line breaks to group code sections that logically belong together can help readability like in this example:

``` haxe
private function resetHelpers():Void
{
	resetFrameSize();
	resetSizeFromFrame();
	_flashRect2.x = 0;
	_flashRect2.y = 0;

	if (graphic != null)
	{
		_flashRect2.width = graphic.width;
		_flashRect2.height = graphic.height;
	}

	centerOrigin();

#if FLX_RENDER_BLIT
	dirty = true;
	getFlxFrameBitmapData();
#end
}
```

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

However, function names should also not be too short - you should be able to roughly know what a function does simply by reading its name - reading its description, if existant, should ideally not be necessary.

An example for a bad / too simple name would be `shoot()` instead of `shootEnemy()`.

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

### Parameter Names

Use lowerCamelCases for function parameters and use `this` to explicitly reference to class members (only when neccessary):

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

In the core of HaxeFlixel, there are a lot of method parameters are capitalized (not preferred in Haxe). This is mostly legacy from the AS3 Flixel's code style and hard to change them all. However, newly written functions should follow the lowerCamelCase style. Also, we encourge contributors to convert them when fixing bugs/updating existing codes.

## Colon Spacing

No extra spaces should be used before and after colons:

| Good                                   | Bad                                    |
| ---------------------------------------| ---------------------------------------|
| `var i:Int;`                           | `var i : Int;`                         |
| `function toString():String`           | `function toString() : String`         |

## Operator Spacing

### Binary Operators

Binary operators should always be surrounded by spaces:

| Good                                   | Bad                                    |
| ---------------------------------------| ---------------------------------------|
| `5 + 2`                                | `5+2`                                  |
| `width / 2`                            | `width/2`                              |
| `i += 2`                               | `i+=2`                                 |

### Unary Operators

For unary operators however, it's preferable not to use any spaces:

| Good                                   | Bad                                    |
| ---------------------------------------| ---------------------------------------|
| `i++`                                  | `i ++`                                 |
| `visible = !visible`                   | `visible = ! visible`                  |



## Leveraging Type Inference

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

However, if there are two many of these sections it be worth considering to split the function into several smaller ones.

There shouldn't be more than one empty line to separate sections.

## Using switch-case as an Expression

Unlike in most other languages with object-oriented syntax, everything in Haxe is an expression. This extends to `switch-case`, meaning that it evaluates to a value. This value can be assinged to a variable, passed to a function or simply returned by a function:

```haxe
private function getColor(color:Color):Int
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
