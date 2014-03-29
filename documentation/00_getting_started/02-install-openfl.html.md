```
title: "Install OpenFL"
```

Installing OpenFL is best done through haxelib. To do so, run the following commands:

``` bash
haxelib install lime
haxelib run lime setup
lime install openfl
```

## Setup

You can begin using OpenFL right away on the Flash, Neko or HTML5 targets, but some targets require a little extra setup.

``` bash
lime setup windows
lime setup android
lime setup blackberry
```

For more information on OpenFL, head on over to [OpenFL.org](http://www.openfl.org/).

## Mac OS X Troubleshooting

* Make sure you have `Command Line Tools for Xcode` installed and updated to your Mac OS X version. You can download it here: [Download For Apple Developers](https://developer.apple.com/downloads/).

* Lime setup requires root permission: `sudo lime setup [target]`.
