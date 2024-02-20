---
title: "FAQ"
---
#### Do I have to learn Flixel (AS3) before HaxeFlixel?
No, you have to learn HaxeFlixel to use HaxeFlixel, although previous experience with the AS3 version will help.

#### Do I have to learn OpenFL to use HaxeFlixel?
No, HaxeFlixel abstracts it completely.

#### Are there any more tutorials?
We have a dedicated [**Community Tutorials** page](https://haxeflixel.com/documentation/community-tutorials) that links to many external community made tutorials! 

You can find the official HaxeFlixel "Dungeon Crawler" tutorial [here](https://haxeflixel.com/documentation/tutorial/).

#### I found a bug, where to report?
On the [official GitHub repository](https://github.com/HaxeFlixel/flixel/issues).

#### My sounds are lagging!?
On some platforms, it helps to manually cache sounds: `FlxG.sound.cache("sound");` or `FlxG.sound.cacheAll();` to do all at once.

#### My player falls off-screen after walking a certain distance!
Collisions are limited to the area defined by `FlxG.worldBounds`. For example in platformers where this area needs to be larger, you need to adjust it manually.

#### Can I make 3D games with HaxeFlixel?
No, the framework is limited to 2D graphics. Well. Except for some [crazy](https://github.com/01010111/flixel-depth) [people](https://github.com/AustinEast/haxeflixel-3D).

#### How do I protect my assets from being stolen?
If you add `embed="true"` to the `<assets path="assets">` tag of the `Project.xml`, the asset files are embedded into the `.exe`.
