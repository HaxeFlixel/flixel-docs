```
title: "Install HaxeFlixel"
```

To install the latest stable version of HaxeFlixel you can use [haxelib](http://lib.haxe.org/) 
from the following command:

``` bash
haxelib install flixel
```

This also automatically installs OpenFL and Lime. After Haxelib has completed you can compile games to Flash. HTML5 and Neko out of the box.

Now run:

```bash
haxelib run lime setup
```

This makes `lime` available as a command (alias for `haxelib run lime`).

To compile to desktop and mobile targets, you have to make sure you have run their respective `lime setup` 
commands are completed, each are specified in the 
[OpenFL platform docs](http://www.openfl.org/documentation/setup/platforms/).

## Updating HaxeFlixel

You can use the following command to update just flixel:
	
``` bash
haxelib update flixel
```

Alternatively, you can update all your haxelib libraries at once with this command:
	
``` bash
haxelib upgrade
```	

## Install flixel command

Run the following command to be able to use [flixel commands](http://haxeflixel.com/documentation/flixel-tools/):
	
``` bash
haxelib install flixel-tools
haxelib run flixel-tools setup
```

## Development version

If you are interested in using bleeding edge code from the development branch [on GitHub](https://github.com/HaxeFlixel/flixel), see [instructions here](/documentation/install-development-flixel).
