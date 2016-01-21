```
title: "Install development Flixel"
```

Developers may want to contribute and or stay updated with the bleeding edge code of Haxeflixel. Like any development code we caution the use of it as it may not have the same amount of testing as the stable version.

All new development is done on the [dev branch](https://github.com/HaxeFlixel/flixel/tree/dev) of the [main GitHub repository](https://github.com/HaxeFlixel/flixel.git).

**Prerequisites**

You must have completed the following Getting Started tutorials:

1.  [Installing Haxe](http://haxeflixel.com/documentation/install-haxe)

If you are wanting to use the latest Haxe toolkit you can see instructions to [build Haxe from source here](http://haxe.org/download/manual_install#building-from-source).

2.  [Installing OpenFl](http://haxeflixel.com/documentation/install-openfl/)

If you are wanting to use the latest OpenFL code, depending on your target there are instructions for building on [OpenFl's main repositories](https://github.com/openfl/openfl#development-build).  You do not have to use the latest OpenFL to use the dev branch of HaxeFlixel.

HaxeLib lets you have multiple versions of a library like Flixel installed at a time.

If you want to remove the one you have currently installed type:

``` bash
haxelib remove flixel
```

You can see the versions of Flixel and other HaxeLib packages like OpenFL with the following command:

``` bash
haxelib list
```

**Update haxelib**

In some cases, your haxelib is not up-to-date. This can cause problems when trying to download the latest flixel snapshot from git. In order to update haxelib, please type in the following command into your console:

``` bash
haxelib selfupdate
```

You should see output similar to the following:

```
Downloading haxelib_client-3,2,0-rc,3.zip...
Download complete : 69579 bytes in 0.2s (310.2KB/s)
  Install src/tools/haxelib/Validator.hx
  Install src/tools/haxelib/SiteApi.hx
  Install src/tools/haxelib/SemVer.hx
  Install src/tools/haxelib/Rebuild.hx
  Install src/tools/haxelib/Main.hx
  Install src/tools/haxelib/Data.hx
  Install src/tools/haxelib/ConvertXml.hx
  Install haxelib.json
  Current version is now 3.2.0-rc.3
Done
Haxelib successfully updated.
rebuild launched
```


**Install flixel from git**

Now you are ready to obtain the newest version. Please input the following command into your console:

``` bash
haxelib git flixel https://github.com/HaxeFlixel/flixel dev
```

You may also want to install the additional [flixel addons](https://github.com/HaxeFlixel/flixel-addons) repository so that you can compile demos that require it:

``` bash
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons.git
```


**Testing your new flixel with the breakout demo**

Everything is setup and just giddy to run those juicy 3.0 demos :) Let's not make 'em wait! Grab the flixel-demo repository and navigate to 'Demos/flixel-demos/Arcade Classics/Breakout'. Start the game by writing:

``` bash
lime test neko
```

or

``` bash
lime test flash
```

**Need more help?**

Check out our [Forum](http://forum.haxeflixel.com) and [#haxeflixel on freenode IRC](irc://chat.freenode.net/#haxeflixel).
