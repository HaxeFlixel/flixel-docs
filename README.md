flixel-docs
===========

The main location for HaxeFlixel documentation.

## Generate the Flixel Docs

### Install chxdoc for Haxe 3

	haxelib git chxdoc git@github.com:ibilon/chxdoc.git
	//move your cwd to this relative path of the project
	cd ./api/chxdoc-gen
	haxelib run chxdoc install

### Run the docs.hxml

	haxe docs.hxml

The docs will now be generated in the `./docs` folder. 