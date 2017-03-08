```
title: "Install HaxeFlixel"
```

To install the latest stable version of HaxeFlixel, open a command prompt and run the following [Haxelib](http://lib.haxe.org/) command:

``` bash
haxelib install flixel
```

This also automatically installs OpenFL and Lime. After the installation is complete, you can compile games to Flash, HTML5 and Neko out of the box.

## Install the `lime` command

```bash
haxelib run lime setup
```

This makes `lime` available as a command (alias for `haxelib run lime`).

To compile to desktop and mobile targets, you have to make sure you have run the respective `lime setup` 
commands. Each are specified in the 
[OpenFL platform docs](http://www.openfl.org/learn/docs/advanced-setup/).

## Install the `flixel` command

Run the following two commands to install [flixel-tools](http://haxeflixel.com/documentation/flixel-tools/) (needed for project templates among other things):

``` bash
haxelib install flixel-tools
haxelib run flixel-tools setup
```

## Updating HaxeFlixel

If a new version of Flixel has been released, and you want to update to it, you can use the following command to do so:

``` bash
haxelib update flixel
```

If you wanted to update e.g. `flixel-addons` instead, just replace `flixel` with `flixel-addons`.

To stay informed about new releases, you can follow [@HaxeFlixel](https://twitter.com/HaxeFlixel) on Twitter or check out our [Blog](http://haxeflixel.com/blog/) from time to time.

## Development version

If you are interested in using bleeding edge code from the development branch [on GitHub](https://github.com/HaxeFlixel/flixel), see [instructions here](/documentation/install-development-flixel).
