```
title: "FlxSave"
```

HaxeFlixel gives you the FlxSave class to manage saving and loading your game's data. You might use it to save and load a high score table, or the position and status of the player and enemies, or custom settings the player has selected. Like most of HaxeFlixel, FlxSave is cross-platform in functionality.

To use FlxSave you need a variable typed to that class. You can create your own variable (perhaps in your registry class, in your gameplay FlxState, or as a local variable in your save/load functions). You may also use the one that HaxeFlixel itself uses (FlxG.save).

The example code used below is largely taken from the [HaxeFlixel save demo](http://www.haxeflixel.com/demos/save). If you have already installed HaxeFlixel, then to install the demo project just open a command line utility, navigate to the folder you would like to install into, and enter the command flixel create Save, or download the source via github using the link on the demo web page.

#### Saving

So how can you save some of your game data? Once you have your variable, you will need to initialize, then bind it:

``` haxe
_gameSave = new FlxSave(); // initialize
_gameSave.bind("SaveDemo"); // bind to the named save slot
```

Note the string "SaveDemo". This is how HaxeFlixel tracks what save slot you are binding to in local storage. If you want to have multiple saves, you will probably want to define a series of strings to identify each slot, eg. "SaveSlot1", "SaveSlot2", etc. and bind to the appropriate one. For more information on using multiple save slots, take a look at [Wolfgang's article](http://www.funstormgames.com/blog/2012/01/flixel-advanced-saving-tips-tricks/) on the subject for AS3 Flixel, but keep in mind that [the AS3 syntax is a little different from Haxe](http://haxeflixel.com/wiki/as3-haxe-comparison).

Note: If you plan to use FlxG.save you can skip the initializing and binding steps, as HaxeFlixel has done it for you.

Once bound, the save is essentially "live". To write to it you use the .data property of variable, treating it as an [object](http://haxe.org/ref/dynamic):

``` haxe
_gameSave.data.boxPositions = new Array();
_gameSave.data.boxPositions.push(new FlxPoint(box.x, box.y));

_gameSave.data.enemy = myEnemy;
```

In certain cases you may need to [serialize and unserialize](http://haxe.org/manual/serialization) your data (fancy words for "take my data and turn it into a specially formatted string, or back into data") to avoid errors, but you may want to try it without serialization unless you experience problems.

#### Loading

In order to retrieve your saved data, you simply make sure you have a correctly bound FlxSave variable and read each value from the .data property.

``` haxe
box.x = _gameSave.data.boxPositions[tempCount].x;
box.y = _gameSave.data.boxPositions[tempCount].y;

```

This means that, depending on your save needs, when loading a save slot you may need to loop through a long list of data to assign each of the values back to it's correct home.

#### Existing save data

When you save data to a given FlxSave save slot there is, of course, the possibility that data already exists in that slot (hopefully your saved data from an earlier save). One way to test for this is to check if one of your variables is null. If save data does already exist and you plan to save an entire fresh set of new data, then to avoid carrying over values from an earlier save you may wish to either go through and initialize or reset each of the potentially saved variables to some default value (or null) before saving your new set, or you may wish to erase the save data entirely (probably not a good idea if you're using FlxG.save).

FlxSave provides an .erase() method to help with this process, but keep in mind that calling it on a bound FlxSave variable will: immediately erase all the data in .data, save the slot in the erased state (any earlier data is now completely gone), and also destroy the binding to the save slot. This last point is important to note, as after the binding has been broken FlxSave may still let you assign to .data and even call other methods without errors to indicate that the data is not actually being stored at all. So if you do use the .erase() method, don't forget to call .bind() again before you save or load any further data.

#### Other methods

In the Save demo the application creates and binds a FlxSave variable when the demo state initializes (see PlayState.create() ), and then leaves this variable accessible for loading and saving from that point on. This allows you to continually update the save object when necessary, but it's equally valid to create, initialize, and bind a FlxSave variable only when loading and saving. In that case you should familiarize yourself with .close() and .destroy() for safe and efficient handling of your FlxSave.

To review these additional methods and check out any other FlxSave functionality in more detail, take a look at the [API documentation on the AS3 Flixel equivalent](http://flixel.org/docs/org/flixel/FlxSave.html) or look at the class definition itself (currently under the util package in the flixel library).