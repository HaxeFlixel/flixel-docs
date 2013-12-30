```
title: "Flixel Display List"
```
The Flixel Display list is a specially designed structure for your game's sprites to be rendered.

#### FlxSprites != Flash Sprites

OpenFL has a [display list](http://www.adobe.com/devnet/flash/quickstart/display_list_programming_as3.html) that is populated by adding [display objects](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html) in a parent child relationship. Sprites are an extended from of Display Objects that has extended features they can be added, removed and can have their parent and children's depth changed with an easy to use api.

It is a common misconception for Flash Developers to assume that FlxSprites in Flixel work like the flash Sprites. FlxSprites also do not share the Event system Flash Sprites have, so addEventListener is also not available or necessary in most situations.

For performance reasons Flixel has its own independent display list and it renders all of its FlxSprites onto a single flash DisplayObject with each FlxCamera. For this reason you cannot add a flash.display.sprite to a FlxState and you cannot add a FlxSprite to the main flash stage.

You can see the display objects used in a typical Flixel game in this diagram. Note you can still place display objects above or below Flixel's camera.

<img src="/images/flixel-display-list.png" style="max-width:400px" />