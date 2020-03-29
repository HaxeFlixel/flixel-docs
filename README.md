![](https://raw.github.com/HaxeFlixel/haxeflixel.com/master/src/files/images/flixel-logos/flixel-docs.png)

[flixel](https://github.com/HaxeFlixel/flixel) | [addons](https://github.com/HaxeFlixel/flixel-addons) | [ui](https://github.com/HaxeFlixel/flixel-ui) | [demos](https://github.com/HaxeFlixel/flixel-demos) | [tools](https://github.com/HaxeFlixel/flixel-tools) | [templates](https://github.com/HaxeFlixel/flixel-templates) | [docs](https://github.com/HaxeFlixel/flixel-docs) | [haxeflixel.com](https://github.com/HaxeFlixel/haxeflixel.com)

[![CI](https://img.shields.io/github/workflow/status/HaxeFlixel/flixel-docs/CI.svg?logo=github)](https://github.com/HaxeFlixel/flixel-docs/actions?query=workflow%3ACI)

## About

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
	
API documentation is provided in the `./api` folder, they are currently generated with [dox](https://github.com/HaxeFlixel/dox). You can view the API docs offline by cloning this directory, checking out the `gh-pages` branch, running `nekotools server` in `./api` and navigating to [localhost:2000](http://localhost:2000/).

To generate the API docs yourself, you need to first run `npm install` in `api/dox`. Then run the following from the root directory:

```
haxe --cwd api --run Make xml pages server
```

The docs will now be generated in the `api/dox/out` folder and a local webserver started at `localhost:2000`.

Note this will use your locally enabled haxelib flixel versions, e.g. if you have `haxelib git flixel` set to `dev` etc.
