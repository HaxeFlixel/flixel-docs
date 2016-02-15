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

### Other:

Moved `FlxTextField` to flixel-addons:

| HaxeFlixel 3.3.x                                  | HaxeFlixel 4.0.0                                   |
| --------------------------------------------------|----------------------------------------------------|
| `import flixel.text.FlxTextField`                 | `import flixel.addons.text.FlxTextField`           |