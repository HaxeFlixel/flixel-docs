```
title: "Using HaxeLib"
```

Haxelib is a package manager and utility that comes with your Haxe install. Here are the most used commands, the full usage docs are [available here](http://haxe.org/doc/haxelib/using_haxelib).

### Install a Library

Install a HaxeLib library from [lib.haxe.org](http://lib.haxe.org/):

```
haxelib install <project>
```

Install a HaxeLib library from git:

```
haxelib git <url> <branch>
```

Update your HaxeLib libraries, including the git ones:

```
haxelib upgrade
```

Set a HaxeLib at a specific version:

```
haxelib set <haxelib-name> <version>
```

Remove a Haxe library:

```
haxelib remove <project>
```

### Update Haxelib itself:

To make sure you are using the latest version of Haxelib you can run the update command. This will update Haxelib itself by automatically downloading the latest version.

```
haxelib selfupdate
```