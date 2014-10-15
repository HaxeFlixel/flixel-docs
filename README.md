![](https://raw.github.com/HaxeFlixel/haxeflixel.com/master/src/files/images/flixel-logos/flixel-docs.png)

[flixel](https://github.com/HaxeFlixel/flixel) | [addons](https://github.com/HaxeFlixel/flixel-addons) | [ui](https://github.com/HaxeFlixel/flixel-ui) | [demos](https://github.com/HaxeFlixel/flixel-demos) | [tools](https://github.com/HaxeFlixel/flixel-tools) | [templates](https://github.com/HaxeFlixel/flixel-templates) | [docs](https://github.com/HaxeFlixel/flixel-docs) | [haxeflixel.com](https://github.com/HaxeFlixel/haxeflixel.com)

##About

This is the main location for HaxeFlixel documentation. Pull requests from this location will be pushed to the live website periodically, so please help us improve the HaxeFlixel docs.

## Contents

* The "main" documentation available on [haxeflixel.com/documentation](http://www.haxeflixel.com/documentation).
* The API documentation.

### Main documentation

The main documentation is made up of `*.html.md` files in the `./documentation` folder. Each file and folder starts with a numerical prefix specifying the order listed on the [docpad website](https://github.com/HaxeFlixel/haxeflixel.com).

Additional pages can be added using the same extension and using a header specifying the title as seen in the other pages. Eg:

	```
	title: "Documentation Page"
	```
	
	Use Regular GitHub flavoured markdown for the page.
	Note `title:` above is case sensitive.

The markdown syntax used in the docs is the  [GitHub-Flavored-Markdown](https://help.github.com/articles/github-flavored-markdown), thus it's very convenient to directly edit the files via GitHub's web editor. 

### API documentation
	
Api documentation is provided in the `./api` folder, they are currently generated with [dox](https://github.com/dpeek/dox). You can view the API docs offline by opening the index.html file in a browser. 

To generate the API docs yourself use the following method:

* Install dox (for instructions refer to [their readme](https://github.com/dpeek/dox/blob/master/README.md))
* Generate the API docs (navigate to `api/dox-gen`)
 * Run the genxml.bat
 * Run the gendocs.bat

Note this will use your localy enabled haxelib flixel versions, e.g. if you have `haxelib git flixel` set to `dev` etc.

The docs will now be generated in the `api/dox-gen/output` folder.
