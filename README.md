flixel-docs
===========

The main location for HaxeFlixel documentation that is also hosted on [haxeflixel.com](haxeflixel.com).

This repo contains the api documentation inside the api folder and the main [haxeflixel.com/documentation](haxeflixel.com/documentation) in the documentation folder. 

Pull requests from this location will be pushed to the live website periodically, so please help us improve the HaxeFlixel docs.

### Main Documentation

The main documentation is made up of `*.html.md` files with a numerical prefix specifying the order listed on the [docpad website](https://github.com/HaxeFlixel/haxeflixel.com). Additional pages can be added using the same extension and using a header specifying the title as seen in the other pages.

The markdown syntax used in the docs is the  [github-flavored-markdown](https://help.github.com/articles/github-flavored-markdown).

### How to Generate the API Docs

#### Install chxdoc for Haxe 3

	haxelib git chxdoc git@github.com:ibilon/chxdoc.git
	//move your cwd to this relative path of the project
	cd ./api/chxdoc-gen
	haxelib run chxdoc install

#### Run the docs.hxml

	haxe docs.hxml

The docs will now be generated in the `./docs` folder. 
