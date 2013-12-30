```
title: "Code Style"
```

HaxeFlixel is following most of the key style found in the original Flixel AS3 library.
Over the most recent HaxeFlixel releases a large amount of the codebase has been modified to follow these style choices.
If you encounter code in the codebase that does not fall under these guidelines please submit a pull-request.

----

#### Functions

Capitalized letters for function parameters:

``` haxe
function translate( Words:String, Fish:BableFish ):Void
```

Instead of:

``` haxe
function translate( words:String, fish:BableFish ):Void
```

##### Simplify the function names:

```
function shootEnemy(Target:Enemy, Bullet:BulletType):Void
```

Easier to read than:

```
function shootAtASpecificEnemyWithABulletTypeOf(Target:Enemy, Bullet:BulletType):Void
```

----

####Curley Braces

Use line breaks in methods, operators etc where possible:

``` haxe
function createAwesome( Boring:Stuff, Creative:Things ):Void
{
	//code
}
```

Instead of:

``` haxe
function createAwesome( Boring:Stuff, Creative:Things ):Void {
	//code
}
```

If the logic is simple enough it is acceptable to omit using them completely:

``` haxe
function createAwesome():Bool
	return _surprise;
```

----

#### Local Variables

Use an underscore prefix for any private variable:

``` haxe
private var _awesome:Awesome;
```

Do not use a prefix for a public variable:

``` haxe
public var awesome:Awesome;
```

##### Private and Public

Declare private members after public members where possible.
Public fields are more important than private members for people looking at the class for reference.

----

#### Strictly Type ambiguous variables

The Haxe compiler does not require you to declare the Type of a variable in some contexts however doing so improves the readability of the code:

``` haxe
var mystery:Answer = createAnAnswer();

//This is unnecessary
var name:String = "Merlin";
var number:Int = 32;

//This is preferred
var name = "Merlin";
var number = 32;
```

----

#### Use of .this

When the use of this.foo is not necessary:

``` haxe
//Inside a FlxSprite

//This is unnecessary
if (this.animation.finished)

//This is preferred
if (animation.finished)
```
