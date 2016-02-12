```
title: "Using Haxelib"
```

Haxelib is a package manager and utility that comes with your Haxe install. Here are the most used commands, the full usage docs are [available here](http://haxe.org/doc/haxelib/using_haxelib).

### Installing a Library

Install a Haxelib library from [lib.haxe.org](http://lib.haxe.org/):

```
haxelib install <library>
```

Install a Haxelib library from Git:

```
haxelib git <library> <url> <branch>
```

_Note: `haxelib git` enables the development directory for that library, which silently prevents `haxelib set` from working. Use `haxelib dev <library>` to disable it._

Update your Haxelib libraries, including the ones from Git:

```
haxelib upgrade
```

Change to different version of a library:

```
haxelib set <library> <version>
```

Remove a library:

```
haxelib remove <library>
```

### Updating Haxelib itself

To make sure you are using the latest version of Haxelib you can run the `selfupdate` command.

```
haxelib selfupdate
```
