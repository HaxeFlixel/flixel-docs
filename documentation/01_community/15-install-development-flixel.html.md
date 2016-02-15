```
title: "Install development Flixel"
```

Developers may want to contribute and / or stay updated with the bleeding edge code of HaxeFlixel. Like any development code we caution the use of it as it may not have the same amount of testing as the stable version.

All new development is done on the dev branches of [HaxeFlixel's GitHub repositories](https://github.com/HaxeFlixel).

**Prerequisites**

You must have completed the following Getting Started tutorials:

* [Installing Haxe](http://haxeflixel.com/documentation/install-haxe)

* [Installing OpenFL](http://haxeflixel.com/documentation/install-openfl/)

If you are wanting to use the latest OpenFL code, depending on your target there are instructions for building on [OpenFL's main repositories](https://github.com/openfl/openfl#development-build). You do not have to use the latest OpenFL to use the dev branch of HaxeFlixel.

Haxelib lets you have multiple versions of a library like Flixel installed at a time. You can see the versions of Flixel and other Haxelib packages like OpenFL with the following command (with the active version in square brackets):

``` bash
haxelib list
```

* Install Git

Windows-only note: ensure that during the installation process, you select the non-default option that allows you to use Git from the Windows command prompt (you'll also need to re-open your command prompt window after installation for Git to become available there).

**Install Flixel from GitHub**

To obtain the newest version, please input the following command into your console:

``` bash
haxelib git flixel https://github.com/HaxeFlixel/flixel
```

The same applies for any additional Flixel libraries:

``` bash
haxelib git flixel-demos https://github.com/HaxeFlixel/flixel-demos
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
haxelib git flixel-ui https://github.com/HaxeFlixel/flixel-ui
```

Should you want to use `haxelib set <library> <version>` to switch back to released versions, be sure to run `haxelib dev <library>` beforehand. `haxelib git` enables the "development directory" for a library, which causes a silent failure of `haxelib set`.

**Testing the installation with the Mode demo**

Navigate to `flixel-demos/Platformers/Mode`. Compile and run the game with `lime test <target>`.

**Need more help?**

Check out our [forum](http://forum.haxeflixel.com) and [#haxeflixel on freenode IRC](irc://chat.freenode.net/#haxeflixel).
