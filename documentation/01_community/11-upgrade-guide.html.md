```
title: "Upgrade Guide"
```

## Upgrading from HaxeFlixel 2.x to 3.0

HaxeFlixel 3.0 is an evolution of the original Flixel api and while most of the API is very similar and quickly learnt, it requires some renames and modifications to update your code.

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

HaxeFlixel has system Assets for its debugger buttons, system sounds etc these assets were previously stored in every project in the assets/data folder. HaxeFlixel 3.x uses the OpenFL include.xml in core HaxeFlixel to omit the need to include them in every project. 

So you dont need to have system assets anymore, everything in your project's `./assets/*` folder should only be the assets you create.

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

A collection of most of the api name changes were collected for the [flixel-tools command line tool](/documentation/community/flixel-tools).
You can see what it [replaces here](https://github.com/HaxeFlixel/flixel-tools/blob/dev/src/legacy/FindAndReplace.hx).

To run the find and replace the command is simple:

```
flixel convert
```

### FlxG Changes

The main changes that developer's will notice is as follows:

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
