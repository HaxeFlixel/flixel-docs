```
title: "Flixel Extensions"
```
## HaxeFlixel Unofficial Libraries and Classes 
### Libraries
[Flixel-Rpg ([Kevin Resol](https://github.com/kevinresol))](https://github.com/kevinresol/flixel-rpg): a RPG framework based on HaxeFlixel, including a set of essential components to build an RPG such as:
- Item/inventory/equipment system
- Trade system
- AI system
- Stats (attributes) system
- Dialog system
and more (maybe multiplayer in the future).

[HaxeFlixel Godot Parser([Pekka Heikkinen](https://github.com/volvis))](https://github.com/volvis/HaxeFlixel-Godot_Parser)(development stopped): Experimental tools for reading Godot scenes into HaxeFlixel.HaxeFlixel lacks a common IDE for managing objects. Godot, while a fully functional game engine, is at the time of writing still in its infancy. However the IDE offers plenty of attractive tools for content authoring. The idea here is to read in Godot scene files, which can be saved as plain text XML, and recreate the Node2D items in HaxeFlixel.

**Pekka's note**: While reading Godot scenes was making good headway, it's become an issue that Godot objects tend to have parenting and operate in local coordinates. Maintaining this relationship through HaxeFlixel, which to my knowledge doesn't support it, is quite a challenge. Maybe even impossible.

[IceEntity ([Nico May](http://nicom1.github.io/))](https://github.com/NicoM1/IceEntity): A simple framework for managing entitys and components in haxeflixel. 



### Classes
[Densities Test ([Tembac](https://github.com/Tembac))](https://github.com/Tembac/DensitiesTest)(HaxeFlixel): A project that demonstrates a method of changing graphics based on the device resolution.  

[Flixel Plugins([Pekka Heikkinen](https://github.com/volvis))](https://github.com/volvis/FlixelPlugins)(OLD): A hopefully growing collection of plugins and experiments for HaxeFlixel. Contains:
- **VisualDebug.hx**: This plugin was created for the sole purpose of drawing debug information on the screen a lot easier. There are only a handful of basic types right now, but the number will grow should the need arise. Every shape can be given an age so you could, for example, track the flight path of a shape; You can use VisualDebug.hilight() to bring focus to individual FlxObjects.
- **AbstractObjectGroup.hx**: This is an experimental typed interface for FlxTypedGroup. It behaves somewhat identical to FlxSpriteGroup, except it works with FlxObjects. It's designed for situations where you have an entity that consists of one hitbox and one or more sprites for graphic.

[Flixel-Plus ([Malody Hoe](https://twitter.com/maddhoexD))](https://github.com/madhoe/flixel-plus): Flixel-plus is a library that contains additional classes for HaxeFlixel. The core class, FlxPlus, contains simple, helper functions to make life easier. Contains:
- **FlxPlus.hx**: A static class that contains misc functions: getMusicTime, playPersistingSound,tempChangeTimeScale, sleep, quit, remapValue. 
- **FlxFadingEmitter.hx**: A FlxEmitterExt that fades out old particles. For now, only works on particles that live forever.
- **RatioStageSizeScaleMode.hx**: A ScaleMode that resizes the stage to the window's size,but keeps aspect ratio.Essentially a combination of RatioScaleMode and StageSizeScaleMode.
- **FlxSplashPlus.hx**: A FlxSplash that fixes centering of logo on mobile, and also includes a handy initDefaults.
- **FlxRandomStack.hx**: An object to manage a color scheme. Not very intuitive.
- **FlxRandomStack.hx**: An object that simulates a random stack/bag of values.


[Flixel-Retrotools ([Vinicius Menezio](https://www.facebook.com/retromaze))](https://github.com/vmenezio/flixel-retrotools): a collection of useful classes that expand on HaxeFlixel's capabilities. Includes:
- **RMZcontroller.hx**: The class binds key presses - or combinations of key presses - to methods that need to be reused multiple times (bindPressed, bindJustPressed, bindJustReleased, CheckKeyPress).
- **RMZTiledObject.hx**: The class serves to help translate an internal object from a .tmx file, with all it's properties, into a fully functional FlxSprite to be used inside the game.
- **RMZtilemap.hx**: The class facilitates the use of Tiled tilemaps, providing methods to allow easy access to the properties, tile layers and object layers contained in a .tmx file.
- **RmzActor.hx**: The class expands the functionaly of the FlxSprite making it easier to create sprites meant to move around the screen, interact with other objects and respond to keyboard controls.
- **RmzCollider.hx**:  The class offers a foundation for simple objects that must respond to collisions, such as hitboxes, bullets or collectibles.


[Flixel-Wrapper ([Kevin Resol](https://github.com/kevinresol))](https://github.com/kevinresol/flixel-wrapper): a simple game wrapper for HaxeFlixel. Contains: 
- **FlxStateManager.hx**: new, add, switchTo.
- **FlxTypedStateManager.hx**: new, add, aswitchTo.
- **IFlxHighScore.hx**: Initial Commit.

[Haxeflixel My-Addons ([l0rb](https://github.com/l0rb))](https://github.com/l0rb/haxeflixel-my-addons): some self coded addons for haxeflixel that I use. Contains: MyMute.hx, MyText.hx, MyButton.hx (fixed FlxButtonPlus), MyMessage.hx (A useful text-state), MyPause.hx (A pause button and a sub-state), MySpeed.hx (A button to change game's speed). 


[Minimal game structures using HaxeFlixel ([Vinícius K. Daros] (http://uspgamedev.org))](https://github.com/uspgamedev/haxeflixel): Minimal game structures using HaxeFlixel. Contains:
- Example 01: Explosion.hx, LoseState.hx, PreLoader.hx, Sprite.hx (+anchor), State.hx + StateManager.hx (html5 fix), WinState.hx 
- Example 02: Button.hx.  


## AS3 Flixel classes that are worth porting to Haxe

[FlxAchievementSystem ([Tal Datner](http://www.chameneon.com/))](https://github.com/Tal3D/FlxAchievementSystem)(AS3):The FlxAchievementSystem is a class built on Flixel that handles global achievements for individual games. It utilizes flash's shared object (or FlxSave) to save achievement progress.


