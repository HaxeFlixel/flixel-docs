```
title: "FAQ"
```

#### Do I have to learn Flixel (AS3) before HaxeFlixel?
No, you have to learn HaxeFlixel to use HaxeFlixel, although previous experience with the AS3 version will help.

#### Do I have to learn ActionScript before Haxe?
No, although previous experience will help.

#### Do I have to learn OpenFL to use HaxeFlixel?
No, HaxeFlixel abstracts it completely.

#### Are there any tutorials?

- [@SeiferTim's](https://twitter.com/SeiferTim) [Dungeon Crawler Tutorial](http://haxeflixel.com/documentation/tutorials/)

- [atomicptr's](https://github.com/atomicptr/GameMechanicExplorer-HaxeFlixel) [Game Mechanic Explorer port](http://gme.qr9.de/)

- [Videos from Christopher Butler](https://www.youtube.com/watch?v=LpKvSPwHOP8&list=PLi0ypjD5PcV9xdjycW0hYi_HD297012tE)
(covering everything from installation to prototyping a platformer).

#### I found a bug, where to report?
On the [official GitHub repository](https://github.com/HaxeFlixel/flixel/issues).

#### Will next-gen consoles be supported?
Eventually, yes! Read more about it [here](https://groups.google.com/d/topic/haxeflixel/NUOpgGUKMvE/discussion).

#### My sounds are lagging!?
On some platforms, it helps to manually cache sounds: `FlxG.sound.cache("sound");` or `FlxG.sound.cacheAll();` to do all at once.

#### My player falls off-screen after walking a certain distance!
Collisions are limited to the area defined by `FlxG.worldBounds`. For example in platformers where this area needs to be larger, you need to adjust it manually.

#### Can I make 3D games with HaxeFlixel?
No, the framework is limited to 2D graphics.

#### How do I protect my assets from being stolen?
If you add `embed="true"` to the `<assets path="assets">` tag of the `Project.xml`, the asset files are embedded into the `.exe`.
