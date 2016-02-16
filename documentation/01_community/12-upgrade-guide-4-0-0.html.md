```
title: "Upgrade Guide 4.0.0"
```

This guide is intended for users upgrading projects from version 3.3.x to 4.0.0. For non-breaking changes, please refer to the [changelog](https://github.com/HaxeFlixel/flixel/blob/master/CHANGELOG.md).
	
The minimum required Haxe version for this release is 3.2.0.

A lot of changes can be handled with a simple find-and-replace in the editor of your choice.

### `elapsed` argument added to `update()`

The function signaure of `update()` changed to `update(elapsed:Float)`. `FlxG.elapsed` is still available, but it is recommended to use the argument value instead.

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                      |
| --------------------------------------------------|-------------------------------------------------------|
| `override public function update():Void`          | `override public function update(elapsed:Float):Void` |
| `super.update();`                                 | `super.update(elapsed);`                              |
| `x += 100 * FlxG.elapsed;`                        | `x += 100 * elapsed;`                                 |

### Introduction of `flixel.math`

A new `flixel.math` package was added. A number of `flixel.util` classes have been moved there:

| HaxeFlixel 3.3.x                        | HaxeFlixel 4.0.0                      |
| --------------------------------------- |---------------------------------------|
| `import flixel.util.FlxMath`            | `import flixel.math.FlxMath`          |
| `import flixel.util.FlxPoint`           | `import flixel.math.FlxPoint`         |
| `import flixel.util.FlxVector`          | `import flixel.math.FlxVector`        |
| `import flixel.util.FlxRect`            | `import flixel.math.FlxRect`          |
| `import flixel.util.FlxAngle`           | `import flixel.math.FlxAngle`         |
| `import flixel.util.FlxVelocity`        | `import flixel.math.FlxVelocity`      |
| `import flixel.util.FlxRandom`          | `import flixel.math.FlxRandom`        |

### Move of "typed" classes:

Typed classes have been moved into the modules of the non-typed versions:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `import flixel.group.FlxTypedGroup`               | `import flixel.group.FlxGroup`                     |
| `import flixel.group.FlxTypedSpriteGroup`         | `import flixel.group.FlxSpriteGroup`               |
| `import flixel.effects.particles.FlxTypedEmitter` | `import flixel.effects.particles.FlxEmitter`       |
| `import flixel.ui.FlxTypedButton`                 | `import flixel.ui.FlxButton`                       |

### Changed integer constants to enums:

ActionScript 3 does not have enums, which is why a lot of these "value sets" were implemented using integer constants. For improved type-safety and to better fit the Haxe coding style, they have been converted to enums:

As long as it's not ambigious, Haxe allows using just the enum value name without the enum's name. In the first case, the enum also does not need to be imported. For example, this means that both of these syntaxes are valid:

```haxe
FlxG.camera.follow(LOCKON);
FlxG.camera.follow(FlxCameraFollowStyle.LOCKON);
```

Which of these two styles is used is mostly a matter of personal preference.

#### `FlxCamera` follow styles:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxCamera.SHAKE_BOTH_AXES`                       | `flixel.util.FlxAxes.XY`                           |
| `FlxCamera.SHAKE_HORIZONAL_ONLY`                  | `flixel.util.FlxAxes.X`                            |
| `FlxCamera.SHAKE_VERTICAL_ONLY`                   | `flixel.util.FlxAxes.Y`                            |

#### `FlxCamera` shake modes:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxCamera.STYLE_LOCKON`                          | `FlxCameraFollowStyle.LOCKON`                      |
| `FlxCamera.STYLE_NO_DEAD_ZONE`                    | `FlxCameraFollowStyle.NO_DEAD_ZONE`                |
| `FlxCamera.STYLE_PLATFORMER`                      | `FlxCameraFollowStyle.PLATFORMER`                  |
| `FlxCamera.STYLE_SCREEN_BY_SCREEN`                | `FlxCameraFollowStyle.SCREEN_BY_SCREEN`            |
| `FlxCamera.STYLE_TOPDOWN`                         | `FlxCameraFollowStyle.TOPDOWN`                     |
| `FlxCamera.STYLE_TOPDOWN_TIGHT`                   | `FlxCameraFollowStyle.TOPDOWN_TIGHT`               |

#### `FlxText` border styles:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxText.BORDER_NONE`                             | `FlxTextBorderStyle.NONE`                          |
| `FlxText.BORDER_OUTLINE`                          | `FlxTextBorderStyle.OUTLINE`                       |
| `FlxText.BORDER_OUTLINE_FAST`                     | `FlxTextBorderStyle.OUTLINE_FAST`                  |
| `FlxText.BORDER_SHADOW`                           | `FlxTextBorderStyle.SHADOW`                        |

#### `FlxTilemap` auto-tiling options:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxTilemap.ALT`                                  | `FlxTilemapAutoTiling.ALT`                         |
| `FlxTilemap.AUTO`                                 | `FlxTilemapAutoTiling.AUTO`                        |
| `FlxTilemap.OFF`                                  | `FlxTilemapAutoTiling.OFF`                         |

#### `FlxBar` fill directions:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxBar.FILL_BOTTOM_TO_TOP`                       | `FlxBarFillDirection.BOTTOM_TO_TOP`                |
| `FlxBar.FILL_HORIZONTAL_INSIDE_OUT`               | `FlxBarFillDirection.HORIZONTAL_INSIDE_OUT`        |
| `FlxBar.FILL_HORIZONTAL_OUTSIDE_IN`               | `FlxBarFillDirection.HORIZONTAL_OUTSIDE_IN`        |
| `FlxBar.FILL_LEFT_TO_RIGHT`                       | `FlxBarFillDirection.LEFT_TO_RIGHT`                |
| `FlxBar.FILL_RIGHT_TO_LEFT`                       | `FlxBarFillDirection.RIGHT_TO_LEFT`                |
| `FlxBar.FILL_TOP_TO_BOTTOM`                       | `FlxBarFillDirection.TOP_TO_BOTTOM`                |
| `FlxBar.FILL_VERTICAL_INSIDE_OUT`                 | `FlxBarFillDirection.VERTICAL_INSIDE_OUT`          |
| `FlxBar.FILL_VERTICAL_OUTSIDE_IN`                 | `FlxBarFillDirection.VERTICAL_OUTSIDE_IN`          |

#### `FlxG.html5` browser types:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `HTML5FrontEnd.INTERNET_EXPLORER`                 | `FlxBrowser.INTERNET_EXPLORER`                     |
| `HTML5FrontEnd.CHROME`                            | `FlxBrowser.CHROME`                                |
| `HTML5FrontEnd.FIREFOX`                           | `FlxBrowser.FIREFOX`                               |
| `HTML5FrontEnd.SAFARI`                            | `FlxBrowser.SAFARI`                                |
| `HTML5FrontEnd.OPERA`                             | `FlxBrowser.OPERA`                                 |

### Changed String constants to abstract enums:

Some static String constants have been changed to abstract enums. This is not a breaking changes, since the old String values are still compatible, but for the sake of type safety it is recommended to use the enum values instead:

As with regular enums, the enum name may be omitted.

#### `FlxText` alignment:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `text.alignment = "left";`                        | `text.alignment = FlxTextAlign.LEFT;`              |
| `text.alignment = "center";`                      | `text.alignment = FlxTextAlign.CENTER;`            |
| `text.alignment = "right";`                       | `text.alignment = FlxTextAlign.RIGHT;`             |

#### `FlxG.keys` keys:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxG.keys.anyPressed(["SPACE", "W"])`            | `FlxG.keys.anyPressed([FlxKey.SPACE, FlxKey.W])`   |
| `FlxG.keys.anyPressed(["SPACE", "W"])`            | `FlxG.keys.anyPressed([SPACE, W])`                 |

### `FlxSprite`:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `getScreenXY()`                                   | `getScreenPosition()`                              |
| `cachedGraphics`                                  | `graphic`                                          |
| `resetFrameBitmaps()`                             | _removed_ (set `dirty` to `true` to regen graphic) |
| `getFlxFrameBitmapData()`                         | `updateFramePixels()`                              |
| `loadGraphicFromTexture()`                        | _removed_ (assign a frames collection to `frames`) |
| `loadRotatedGraphicFromTexture()`                 | _removed_ (assign a frames collection to `frames`) |

### `FlxCamera`:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                            |
| --------------------------------------------------|-------------------------------------------------------------|
| `bounds`                                          | `minScrollX`, `minScrollY`, `maxScrollX` and `maxScrollY`   |
| `setBounds()`                                     | `setScrollBoundsRect()`                                     |
| `follow()`'s `Offset` argument                    | _removed_                                                   |

### `FlxTilemap`:

`loadMap()` has been split up into `loadMapFromArray()` and `loadMapFromCSV()`.

### `FlxGroup`:

`callAll()` and `setAll()` have been removed - use `forEach()` instead:

```haxe
// 3.3.x
group.setAll("scrollFactor", FlxPoint.get(0, 0));
group.callAll("kill");
```

```haxe
// 4.0.0
group.forEach(function(basic:FlxBasic))
{
	basic.scrollFactor.set(0, 0);
	basic.kill();
}
```

### `flixel.input.gamepad`:

The hardware IDs of the different controller types are now mapped to a common `FlxGamepadInputID`. This avoids the need of having to handle multiple controller types - this now happens automatically under the hood.

```haxe
// 3.3.x
if (gamepad.pressed(XboxButtonID.A) ||
	gamepad.pressed(OUYAButtonID.O) ||
	gamepad.pressed(LogitechButtonID.TWO)) {} 
```

```haxe
// 4.0.0
if (gamepad.anyPressed([FlxGamepadInputID.A])) {}
// or
if (gamepad.pressed.A) {}
```

It is still possible to use the IDs from the `flixel.input.gamepad.id` classes via the functions with the `Raw` suffix.

Because of the poor driver support, the PS3 ID class / support for PS3 controllers have been removed.

### `FlxPath`:

`FlxPath#start()` no longer takes a `FlxObject` argument, instead, `FlxObject` now has a path property. This means `FlxObject` takes care of updating the path, taking care of the issue that paths are not paused along with the objects they work on in substates.

```haxe
// 3.3.x
var path = new FlxPath().start(object, points);
```

```haxe
// 4.0.0
object.path = new FlxPath().start(points);
```

### `FlxColor` / `FlxColorUtil` refactor:

`FlxColor` is now an [`abstract`](http://haxe.org/manual/types-abstract.html), which means it can be used like an object, while the underlying type is still a regular `Int`. The static `FlxColorUtil` functions can now be used as member methods or properties:

```haxe
// 3.3.x
var color:Int = 0x008080;
trace(FlxColorUtil.getGreen(color));
```

```haxe
// 4.0.0
var color:FlxColor = 0x008080;
trace(color.green);
```

The amount of colors presets (`FlxColor.RED` etc..) has been reduced.

### `FlxEmitter` refactor:

`FlxEmitterExt` has been merged into `FlxEmitter`. For circular emitters, `FlxEmitterMode.CIRCLE` can be used.

Most properties are now `FlxRangeBounds` objects which have a `min` and a `max` `FlxRange` object.

The separate color component `Bounds` have been merged into a `FlxRangeBounds<FlxColor>`.

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `at()`                                            | `focusOn()`                                        |
| `on`                                              | `emitting`                                         |

#### `FlxParticle` changes:

Most properties are now `FlxRange` objects which have a `start` and an `end` value (for example `velocityRange`).

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `maxLifespan`                                     | `lifespan`                                         |
| `lifespan`                                        | `age` (counts up instead of down)                  |

### `FlxRandom` refactor:

`FlxRandom` can now be instantiated and the static functions are now member methods. A pre-created instance is available via `FlxG.random`.

Some methods have also been renamed or removed:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxRandom.intRanged(min, max)`                   | `FlxG.random.int(min, max)`                        |
| `FlxRandom.floatRanged(min, max)`                 | `FlxG.random.float(min, max)`                      |
| `FlxRandom.chanceRoll(chance)`                    | `FlxG.random.bool(chance)`                         |
| `FlxRandom.weightedGetObject()`                   | _removed_ (`getObject()` now has a range argument) |
| `FlxRandom.colorExt()`                            | _removed_                                          |

### `FlxAngle` changes:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `FlxAngle.getAngle(point1, point2)`               | `point1.angleBetween(point2)`                      |
| `FlxAngle.angleLimit()`                           | _removed_ (use `FlxMath.bound()` instead)          |

There have been several changes to `FlxAngle.rotatePoint()`:

- the y-axis is no longer inverted
- rotation is now clockwise
- moved to `FlxPoint` (`rotate()`)

```haxe
// 3.3.x
var angle = 45;
var point = FlxPoint.get(10, 5);
FlxAngle.rotatePoint(x, y, pivotX, pivotY, angle, point);
```

```haxe
// 4.0.0
var angle = 45;
var point = FlxPoint.get(10 + x, 5 + y);
var pivot = FlxPoint.weak(pivotX, pivotY);
point.rotate(pivot, angle);
```

### `FlxMath` changes:

| HaxeFlixel 3.3.x                                        | HaxeFlixel 4.0.0                                          |
| --------------------------------------------------------|-----------------------------------------------------------|
| `newAmount = FlxMath.wrapValue(value, amount, max + 1)` | `newAmount = FlxMath.wrapValue(value + amount, min, max)` |
| `FlxMath.getDistance(point1, point2)`                   | `point1.distanceTo(point2)`                               |
| `FlxMath.MIN_VALUE`                                     | `FlxMath.MIN_VALUE_FLOAT`                                 |
| `FlxMath.MAX_VALUE`                                     | `FlxMath.MAX_VALUE_FLOAT`                                 |

### Other:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `import flixel.text.FlxTextField`                 | `import flixel.addons.text.FlxTextField`           |
| `FlxPoint#inFlxRect()`                            | `FlxPoint#inRect()`                                |
| `FlxRect#containsFlxPoint()`                      | `FlxRect#containsPoint()`                          |
| `flixel.plugin.MouseEventManager`                 | `flixel.input.mouse.FlxMouseEventManager`          |
| `flixel.util.loaders.CachedGraphics`              | `flixel.graphics.FlxGraphic`                       |

`FlxVelocity`'s `accelerateTowards*()`-functions now only take a single `maxSpeed` argument (instead of `x` and `y`).

The `complete` option of `FlxTween` is now called `onComplete`.


## flixel-addons

Not all flixel-addons changes are covered here. Please check the [changelog](https://github.com/HaxeFlixel/flixel-addons/blob/master/CHANGELOG.md) for the rest.

### `FlxNapeState` refactor:

`FlxNapeState` is now `FlxNapeSpace` and no longer extends `FlxState`. This makes it possible to use the `flixel.addons.nape` package along with other `FlxState` subclasses (for example `FlxUIState`).

```haxe
// flixel-addons 1.x.x
import flixel.addons.nape.FlxNapeState;

class PlayState extends FlxNapeState
{
	override public function create():Void
	{
		super.create();
	}
}
```

```haxe
// flixel-addons 2.0.0
import flixel.FlxState;
import flixel.addons.nape.FlxNapeSpace;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		FlxNapeSpace.init();
	}
}
```