```
title: "Install Haxe"
```

The Haxe Toolkit is available from [haxe.org/download](http://haxe.org/download) for Windows, Linux and Mac.

## Test Haxe installation

For a simple test to see if Haxe is now working on your system, open a new command prompt / terminal window and type ```haxe```. You should see something like this:

```bash
Haxe Compiler 3.0.1 - (C)2005-2013 Haxe Foundation
 Usage : haxe.exe -main <class> [-swf|-js|-neko|-php|-cpp|-as3] <output> [options]
 [...]
```

## haxelib

Haxe comes with its own library manager called [haxelib](http://lib.haxe.org/), which greatly simplifies installing and updating libraries.

Please make sure you are running the latest version with the self update command:

``` bash
haxelib selfupdate
haxe upgrade.hxml
```

You can see more of how to use haxelib [here](http://haxe.org/doc/haxelib/using_haxelib) and browse Haxe community libraries on the [official site](http://lib.haxe.org/).

## Upgrading Haxe

If you're upgrading from a Haxe 2.x install, you need to uninstall Haxe as well as remove the haxelib folders, in windows you will find them in ```(C:\MotionTwin\...)```.