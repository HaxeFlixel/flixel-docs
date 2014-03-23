```
title: "Upgrade Guide"
```

## Upgrading from HaxeFlixel 3.1.0 to 3.2.0


| HaxeFlixel 3.1.0                        | HaxeFlixel 3.2.0                      |
| --------------------------------------- |---------------------------------------|
| FlxTween.multiVar(object, vars, duration, { delay: 1}); | FlxTween.multiVar(object, vars, duration, { startDelay: 1});| 
| FlxG.camera.followAdjust(4, 5);         | FlxG.cameras.followLead.set(4, 5);    | 
| FlxTilemap.arrayToCSV()                 | FlxStringUtil.arrayToCSV()            |                        
| FlxTilemap.bitmapToCSV()                | FlxStringUtil.bitmapToCSV()           |
| FlxTilemap.imageToCSV()                 | FlxStringUtil.imageToCSV()            |
| FlxMath.computeVelocity()               | FlxVelocity.computeVelocity()         |
| FlxState.setSubState()                  | FlxState.openSubState()               |

## Upgrading from HaxeFlixel 3.0.4 to 3.1.0

HaxeFlixel 3.1 is a continuization of our efforts of making the API cleaner and more intuitive, keeping the amount of bugs as low as possible and adding new features. It is one of the biggest releases so far.

This page is a summary of all breaking changes - for a more in-depth list of changes, please refer to the [changelog](https://github.com/HaxeFlixel/flixel/blob/dev/CHANGELOG.md).

### `FlxTypedButton` / `FlxButton` refactor

`FlxTypedButton` has been completely refactored, which includes the following breaking API changes:

- A new `FlxButtonEvent` class was added for the onDown, onUp, onOver and onOut events. Instead of the `setCallback()`-functions, you now set callbacks like this:

		button.onDown.callback = someFunction;

	This class also contains a `sound` property:
		
		button.onDown.sound = FlxG.sound.load("pathToASound");

	You might say: *"What happened to custom callback arguments? The `callback` has the type `Void->Void`!"*
	While that's true, you can still *use* callback arguments by leveraging [function binding](http://haxe.org/manual/haxe3/migration#callback):

		button.onDown.callback = someFunction.bind(1);

	In that example, `someFunction` is of type `Int->Void` and will always be called with 1.

- `labelOffset:FlxPoint` is now an array (`labelOffsets:Array<FlxPoint>`) which uses the button status constants as indices for more control over the button position.
- The highlight frame of the button spritesheet is now ignored by default on mobile devices, since it does not make much sense there - you can't hover over a button on a touchscreen.
- It is now possible to "swipe-press" a button, which means you can press it if the input (mouse or touch) has been moved over the button and then relased. Previously, you could only press a button if the press happened while you were *already* hovering over the button. This especially makes `FlxVirtualPad` more usable.


### FlxG.keys and FlxG.keyboard

In 3.0.0, FlxG.keyboard has been introduced. However, we realized that this does not make for an intuitive API - you can't tell the difference between the two from their name alone. In fact, even if you have been using the two for a while, it still seems confusing.

This is why me merged the two classes again. This required removing the following functions:

- `FlxG.keyboard.pressed()`
- `FlxG.keyboard.justPressed()`
- `FlxG.keyboard.justReleased()`

You should use the following functions instead:

- `FlxG.keys.anyPressed()`
- `FlxG.keys.anyJustPressed()`
- `FlxG.keys.anyJustReleased()`

Please note that those functions take an `Array<String>` instead of a variable amount of `String`s. So the following...

```haxe
if (FlxG.keyboard.pressed("LEFT", "RIGHT")) {}
```

...becomes:

```haxe
if (FlxG.keys.anyPressed(["LEFT", "RIGHT"])) {}
```

### FlxMouse refactor

The following breaking changes were made during the refactor of `FlxMouse`:


| HaxeFlixel 3.0.x                        | HaxeFlixel 3.1.0                         |
| --------------------------------------- | ---------------------------------------|
| FlxG.mouse.show();                 	  | FlxG.mouse.visible = true;             |
|                   	                  |	FlxG.mouse.load();             |
| FlxG.mouse.hide();                      | FlxG.mouse.visible = false;            |                        
| FlxState.useMouse                		  | *removed*              				   |

Also, the mouse cursor is now visible by default on non-mobile devices.

The middle and right click event listeners are now set up by default, which means `FLX_MOUSE_ADVANCED` has turned into `FLX_NO_MOUSE_ADVANCED`.

### The recording system and `FlxRandom`

To put it bluntly... `FlxRandom` was a bit of a mess in 3.0. Some of the functions were deterministic, others weren't, which as a result made it very difficult to create deterministic games suitable for the recording system.

In 3.1.0, `FlxRandom` has been refactored to be completely deterministic. A new algorithm for pseudo-random-number-generation was implemented, **which makes old replays incompatible** / they will have unpredictable results.

Additionally, the following functions have been added to `FlxRandom`:

- `weightedPick()`
- `weightedGetObject()`
- `colorExt()`

### FlxSprite renamings

A noteworthy amount of fields inside of `FlxSprite` have been renamed to increase the consistency with other parts of the API:

| HaxeFlixel 3.0.x                          | HaxeFlixel 3.1.0                         |
| --------------------------------------- | ---------------------------------------|
| loadfromSprite()                 	  | loadGraphicFromSprite()                |
| setGraphicDimensions()                  | setGraphicSize()            	   |
| bakedRotation				  | bakedRotationAngle                     |
| pixelsOverlapPoint()                    | overlapsPoint()                        |                        
| loadImageFromTexture()                  | loadGraphicFromTexture()               |
| loadRotatedImageFromTexture()           | loadRotatedGraphicFromTexture()        |
| setColorTransformation()                | setColorTransform()                    |

### Scale Modes

HaxeFlixel 3.1.0 introduces scale modes to simplify targetting multiple resolutions. `FlxG.scaleMode` can be an instance of the following classes:

-  `RatioScaleMode` (default!)
-  `FillScaleMode`
-  `FixedScaleMode`
-  `RelativeScaleMode`
-  `StageSizeScaleMode`

This change made `FlxG.autoResize` obsolete and it has thus been removed. 

You can also write a custom scale mode that extends `BaseScaleMode`.

Be sure to check out the [ScaleModes demo](http://haxeflixel.com/demos/ScaleModes/).

### FlxTypedGroup.sort()

The way `FlxTypedGroup.sort()` has been changed for a significant performance improvement. If you want to sort by y, you now have to use the following syntax:

```haxe
group.sort(FlxSort.byY, FlxSort.ASCENDING);
```

Instead of:

```haxe
group.sort("y", FlxSort.ASCENDING);
// or
group.sort();
```

If you want to sort by anything other than `y`, you'll have to write a custom sorting function, as can be seen in this example:

```haxe
function sortByAlpha(Order:Int, Sprite1:FlxSprite, Sprite2:FlxSprite):Int
{
	return FlxSort.byValues(Order, Sprite1.alpha, Sprite2.alpha);
}

// usage on a FlxTypedGroup<FlxSprite>:
group.sort(sortByAlpha);
```

### Other breaking changes

| HaxeFlixel 3.0                          | HaxeFlixel 3.1                         |
| --------------------------------------- | ---------------------------------------|
| FlxTypedGroup.autoReviveMembers       | *removed*            |
| FlxG.gameFramerate                 	|	FlxG.updateFramerate           | 			
| FlxG.flashFramerate                    | FlxG.drawFramerate           |                        
| FlxG.gamepads.get()              		  | FlxG.gamepads.getByID()          |
| FlxG.debugger.visualDebug             | FlxG.debugger.drawDebug                |
| FlxG.paused                           | *removed (didn't have any functionality)*  |
| FlxArrayUtil.intToString()            | FlxStringUtil.toIntArray()                |
| FlxArrayUtil.floatToString()            | FlxStringUtil.toFloatArray()               |
| FlxMisc.openURL()                      | FlxG.openURL()                            |
| FlxMisc                                | *removed*                               | 
| FlxSoundUtil                           | *removed (use a FlxTimer instead)*        |

The classes from `flixel.system.input` have been moved to `flixel.input`.

`FlxPoint`s in `FlxObject` and `FlxSprite` are now read-only / `(default, null)`, which means you need to use .set() on them if you were previously creating new points. The following...

```haxe
sprite.velocity = new FlxPoint(100, 50);
```

...becomes:

```haxe
sprite.velocity.set(100, 50);
```

## Upgrading from HaxeFlixel 2.x to 3.0

HaxeFlixel 3.0 is an evolution of the original Flixel API and while most of the API is very similar and quickly learnt, it requires some renames and modifications to update your code.

### Major changes from version 2.10

We wanted to slim down up the core classes, which meant moving non-essential functionality into separate classes. We've also continued to focus on improving stability and adding features to the engine. Here's a quick overview of the biggest changes:

* Moved __animation logic from [FlxSprite](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/FlxSprite.hx)__, into new [FlxAnimationController](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/animation/FlxAnimationController.hx) class. All animation logic is now accessed through __mySprite.animation__, eg: 

```
mySprite.animation.add(...);

mySprite.animation.play(...);

mySprite.animation.frameName = "String";

mySprite.animation.frameIndex = Int;

//inspect the advanced api features such as
addByNames, addByStringIndicies, addByIndicies, addByPrefix, findSpriteFrame, randomFrame ...

```


* Added new [FlxKeyShortcuts](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/system/input/keyboard/FlxKeyShortcuts.hx) class, which replaces FlxG.keys. __FlxG.keys.pressed is no longer a function__, it's now an object, ex: ```if( FlxG.keys.pressed.ANY ) {...}```

* Added new [FlxSpriteGroup](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/group/FlxSpriteGroup.hx) class, which __allows an FlxGroup to behave like an FlxSprite__. This is a powerful new construct that will simplify building UI controls.

* __FlxU is now gone__, we've moved all its functionality to [several utility classes](https://github.com/HaxeFlixel/flixel/tree/dev/flixel/util) that specific contain functionality, ex: _[FlxArrayUtil](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxArrayUtil.hx), [FlxAngle](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxAngle.hx), [FlxMath](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxMath.hx), [FlxRandom](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxRandom.hx), [FlxSpriteUtil](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxSpriteUtil.hx), [FlxVelocity](https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxVelocity.hx), [etc](https://github.com/HaxeFlixel/flixel/tree/dev/flixel/util)_.

* __FlxSprite Filters__ are now in a separate FlxSpriteFilter utility class.

### Package Structure

HaxeFlixel no longer has an `org` package. Everything is now included as ```flixel.package.Class```. For most cases you can just remove ```org.``` from your import statements.

This was a decision the core developers agreed upon, to make the package structure simpler and detach HaxeFlixel from old flash conventions.

### FrontEnds and the FlxG refactor

Frontends in HaxeFlixel 3.x are a new structure to the core of Flixel and which tackles the often criticized bloated collection of static methods in FlxG.

Frontends are accessed in `FlxG.frontend` in a similar fasion to what Flixel devs are used to. Careful thought has been given to organise them into logical shortcuts. This way the api will be easier browse, remember and maintain.

For example in HaxeFlixel 2.x to add a `FlxCamera` you would use `FlxG.addCamera(camera:FlxCamera);`, this `addCamera` method has been moved into a `camera` frontend with all the other `camera` related shortcuts.
So the code in HaxeFlixel 3.x to add a `FlxCamera` is now `FlxG.cameras.add(camera:FlxCamera)`.

The Flixel FrontEnds are as follows:

* FlxG.inputs
* FlxG.console
* FlxG.log
* FlxG.bmpLog
* FlxG.watch
* FlxG.debugger  
* FlxG.vcr
* FlxG.bitmap    
* FlxG.cameras
* FlxG.plugins
* FlxG.sound

More detail on the FrontEnds can be read on the [FrontEnd docs page](/documentation/flxg-frontends).

### Core Assets

HaxeFlixel has system Assets for its debugger buttons, system sounds, etc. These assets were previously stored in every project in the assets/data folder. HaxeFlixel 3.x uses the OpenFL include.xml in core HaxeFlixel to omit the need to include them in every project. 

So you do not need to have system assets anymore, everything in your project's `./assets/*` folder should only be the assets you create.

### New Debugger and Interactive Console

HaxeFlixel 3.x includes a powerful console and improved debugger. The new debugger system by default redirects the core `trace()` command to the log. Alternativley you can use `FlxG.log.add()` , `FlxG.watch.add()`, `FlxG.log.warn` and more.

### New Flixel Command Line Tools

Our command line tools have been moved to an optional repository, so the old `haxelib run flixel new` command will not work.
Install the tools from haxelib just like flixel and run setup and follow the prompts:

```
haxelib install flixel-tools

haxelib run flixel-tools setup
```

Now you can use the commands with just `flixel`, try the help command for more info.

```
flixel help

//see the new template tool options with:
flixel help template

//Shorthand version to create a template with a custom name
flixel tpl -n "CustomProject"
```

#### Automatic find and replace

A collection of most of the API name changes were collected for the [flixel-tools command line tool](/documentation/community/flixel-tools).
You can see what it [replaces here](https://github.com/HaxeFlixel/flixel-tools/blob/dev/src/legacy/FindAndReplace.hx).

To run the find and replace the command is simple:

```
flixel convert
```

### FlxG Changes

The main changes that developers will notice are as follows:

| HaxeFlixel 2.x                          | HaxeFlixel 3.x                             |
| --------------------------------------- | ------------------------------------------ |
| FlxG.getLibraryName()                   | FlxG.libraryName                           |
| FlxG.setDebuggerLayout                  | FlxG.debugger.setLayout                    |
| FlxG.log                                | trace()                                    |
| FlxG.resetDebuggerLayout                | FlxG.debugger.resetLayout                  |
| FlxG.visualDebug                        | FlxG.debugger.visualDebug                  |
| FlxG.toggleKeys                         | FlxG.debugger.toggleKeys                   |
| FlxG.DEBUGGER_STANDARD                  | FlxDebugger.STANDARD                       |
| FlxG.DEBUGGER_MICRO                     | FlxDebugger.MICRO                          |
| FlxG.DEBUGGER_BIG                       | FlxDebugger.BIG                            |
| FlxG.DEBUGGER_TOP                       | FlxDebugger.TOP                            |
| FlxG.DEBUGGER_LEFT                      | FlxDebugger.LEFT                           |
| FlxG.DEBUGGER_RIGHT                     | FlxDebugger.RIGHT                          |
| FlxG.random                             | FlxRandom.float                            |
| FlxG.shuffle                            | FlxArrayUtil.shuffle                       |
| FlxG.getRandom                          | FlxArrayUtil.getRandom                     |
| FlxG.globalSeed                         | FlxRandom.globalSeed                       |
| FlxG.tween                              | FlxTween.multiVar                          |
| FlxG.resetInput                         | FlxG.inputs.reset                          |
| FlxG.RED                                | FlxColor.RED                               |
| FlxG.GREEN                              | FlxColor.GREEN                             |
| FlxG.BLUE                               | FlxColor.BLUE                              |
| FlxG.PINK                               | FlxColor.PINK                              |
| FlxG.WHITE                              | FlxColor.WHITE                             |
| FlxG.BLACK                              | FlxColor.BLACK                             |
| FlxG.TRANSPARENT                        | FlxColor.TRANSPARENT                       |
| FlxG.DEG                                | FlxAngle.TO_DEG                            |
| FlxG.RAD                                | FlxAngle.TO_RAD                            |
| FlxG.flashGfx                           | FlxSpriteUtil.flashGfx                     |
| FlxG.flashGfxSprite                     | FlxSpriteUtil.flashGfxSprite               |
| FlxG.levels                             | Reg.levels                                 |
| FlxG.scores                             | Reg.scores                                 |
| FlxG.score                              | Reg.score                                  |
| FlxG.saves                              | Reg.saves                                  |
| FlxG.save                               | Reg.save                                   |
| FlxG.addCamera                          | FlxG.cameras.add                           |
| FlxG.useBufferLocking                   | FlxG.cameras.useBufferLocking              |
| FlxG.lockCameras                        | FlxG.cameras.lock                          |
| FlxG.renderCameras                      | FlxG.cameras.render                        |
| FlxG.unlockCameras                      | FlxG.cameras.unlock                        |
| FlxG.removeCamera                       | FlxG.cameras.remove                        |
| FlxG.resetCameras                       | FlxG.cameras.reset                         |
| FlxG.shake                              | FlxG.cameras.shake                         |
| FlxG.bgColor                            | FlxG.cameras.bgColor                       |
| FlxG.warn                               | FlxG.log.warn                              |
| FlxG.error                              | FlxG.log.error                             |
| FlxG.notice                             | FlxG.log.notice                            |
| FlxG.advancedLog                        | FlxG.log.advanced                          |
| FlxG.clearLog                           | FlxG.log.clear                             |
| FlxG.watch                              | FlxG.watch.add                             |
| FlxG.unwatch                            | FlxG.watch.remove                          |
| FlxG.play                               | FlxG.sound.play                            |
| FlxG.playMusic                          | FlxG.sound.playMusic                       |
| FlxG.loadSound                          | FlxG.sound.load                            |
| FlxG.addSound                           | FlxG.sound.add                             |
| FlxG.stream                             | FlxG.sound.stream                          |
| FlxG.destroySounds                      | FlxG.sound.destroySounds                   |
| FlxG.updateSounds                       | FlxG.sound.updateSounds                    |
| FlxG.pauseSounds                        | FlxG.sound.pauseSounds                     |
| FlxG.resumeSounds                       | FlxG.sound.resumeSounds                    |
| FlxG.music                              | FlxG.sound.music                           |
| FlxG.sounds                             | FlxG.sound.list                            |
| FlxG.mute                               | FlxG.sound.muted                           |
| FlxG.volume                             | FlxG.sound.volume                          |
| FlxG.volumeHandler                      | FlxG.sound.volumeHandler                   |
| FlxG.keyVolumeUp                        | FlxG.sound.keyVolumeUp                     |
| FlxG.keyVolumeDown                      | FlxG.sound.keyVolumeDown                   |
| FlxG.keyMute                            | FlxG.sound.keyMute                         |
| FlxG.addPlugin                          | FlxG.plugins.add                           |
| FlxG.getPlugin                          | FlxG.plugins.get                           |
| FlxG.removePlugin                       | FlxG.plugins.remove                        |
| FlxG.removePluginType                   | FlxG.plugins.removeType                    |
| FlxG.updatePlugins                      | FlxG.plugins.update                        |
| FlxG.drawPlugins                        | FlxG.plugins.draw                          |
| FlxG.plugins                            | FlxG.plugins.list                          |
| FlxG.loadReplay                         | FlxG.vcr.loadReplay                        |
| FlxG.reloadReplay                       | FlxG.vcr.reloadReplay                      |
| FlxG.stopReplay                         | FlxG.vcr.stopReplay                        |
| FlxG.recordReplay                       | FlxG.vcr.startRecording                    |
| FlxG.stopRecording                      | FlxG.vcr.stopRecording                     |
| FlxG.checkBitmapCache                   | FlxG.bitmap.checkCache                     |
| FlxG.createBitmap                       | FlxG.bitmap.create                         |
| FlxG.addBitmap                          | FlxG.bitmap.add                            |
| FlxG.removeBitmap                       | FlxG.bitmap.remove                         |
| FlxG.getCacheKeyFor                     | FlxG.bitmap.getCacheKeyFor                 |
| FlxG.getUniqueBitmapKey                 | FlxG.bitmap.getUniqueKey                   |
| FlxG.clearBitmapCache                   | FlxG.bitmap.clearCache                     |
| FlxG.clearAssetsCache                   | FlxG.bitmap.clearAssetsCache               |
