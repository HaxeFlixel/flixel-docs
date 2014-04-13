```
title: "Install HaxeFlixel"
```

HaxeFlixel requires a system with a working installation of OpenFL and Haxe. 
If you havent set this up previously please follow the 
[official install guide](http://www.openfl.org/documentation/setup/) and return here.

To install the latest stable version of HaxeFlixel you can use [haxelib](http://lib.haxe.org/) 
from the following command:

``` bash
haxelib install flixel
```

After Haxelib has completed you can compile games to Flash and Neko out of the box. 

To compile to desktop and mobile targets, you have to make sure you have run their respective `lime setup` 
commands are completed, each are specified in the 
[openfl platform docs](http://www.openfl.org/documentation/setup/platforms/).

## Updating HaxeFlixel

You can use the following command to just update flixel:
	
``` bash
haxelib update flixel
```

Alternatively, you can update all your haxelib libraries at once with this command:
	
``` bash
haxelib upgrade
```	

## Install flixel command

Run the following command to be able to use [flixel commands](https://github.com/HaxeFlixel/flixel-docs/blob/master/documentation/01_community/13-flixel-tools.html.md#commands):
	
``` bash
haxelib install flixel-tools
haxelib run flixel-tools setup
```

## Development version

If you are interested in using bleeding edge code from the development branch [on GitHub](https://github.com/HaxeFlixel/flixel), see [instructions here](/documentation/install-development-flixel).