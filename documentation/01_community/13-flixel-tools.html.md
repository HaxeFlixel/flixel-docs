```
title: "Flixel Tools"
```

To make HaxeFlixel development easier a set of command line tools has been developed with [Haxe](http://haxe.org) and [Neko](http://nekovm.org). With it you can easily create our demo projects, templates and more. Just like HaxeFlixel it is an opensource tool and additions/improvements from the community are welcome at the [Flixel Tools Github repository](https://github.com/HaxeFlixel/flixel-tools).

### Installation:

The latest stable release of the tools is published just like flixel on Haxelib, so installing is easy:

```
haxelib install flixel-tools
```

#### GIT

You need to make sure you have git installed, [git](http://git-scm.com/download/).

### Setup the Tools

To set the tools up initially / to be able to use the `flixel` alias in your console:

```
haxelib run flixel-tools setup
```

### Commands

Create a new demo (in the current directory):

```
flixel create <name_or_number>
```

If no name or number is given it will list all demos and prompt you for a choice, by number or name.

To create a new default game template use the following, with -n option being the name you want:

```
flixel template -n <name>
```

You can compile all demos for specified platform using __testdemos__ command (flash if not specified):

Valid platforms (don't forget the __-__): flash, neko, windows, mac, linux, ios, android, html5 (experimental)

```
flixel testdemos -<platform>
```

- Currently the templates created are only compatible with the latest [dev branch of flixel](https://github.com/HaxeFlixel/flixel). For flixel 2.x use the command: ```haxelib run flixel new -name <name>```

### Install the tools from git:

- Please make sure you are also running the latest version of haxelib you can make sure with the command:

```
haxelib selfupdate
```

#### Run the following set of commands to install the tools:

To clone this repo to your haxelib directory:

```
haxelib git flixel-tools https://github.com/HaxeFlixel/flixel-tools.git
```
