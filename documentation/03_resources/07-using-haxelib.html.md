```
title: "Using Haxelib"
```

Haxelib is a package manager and utility that comes with your Haxe install. Here are the most used commands, the full usage docs are [available here](http://haxe.org/doc/haxelib/using_haxelib).

### Install a Library

Install a Haxelib library from [lib.haxe.org](http://lib.haxe.org/):

```
haxelib install <project>
```

Install a Haxelib library from git:

```
haxelib git <url> <branch>
```

Update your Haxelib libraries, including the git ones:

```
haxelib upgrade
```

Set a Haxelib at a specific version:

```
haxelib set <haxelib-name> <version>
```

Remove a Haxe library:

```
haxelib remove <project>
```

### Update Haxelib itself:

To make sure you are using the latest version of Haxelib you can run the selfupdate command. This will update Haxelib itself by automatically downloading the latest version.

```
haxelib selfupdate
```
