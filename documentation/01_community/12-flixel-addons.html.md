```
title: "Flixel Addons"
```

The HaxeFlixel codebase is large and HaxeFlixel developers have worked to organise the core Flixel repository into the most important features.
Community contributions and plugins that every game wont need is being maintained in the flixel-addons repository.

[Flixel Addons Github repository](https://github.com/HaxeFlixel/flixel-addons)

Flixel Addons is designed to be used with haxelib and hosted on the main HaxeFlixel github account.
Addons can be easily used in your project by adding the following xml node to your project.xml file.

### Install Flixel Addons

Currently you can easily install flixel-addons using haxelib's git feature.

```
//Use this haxelib command in your console
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
```

Now to verify you can see if flixel-addons is in your haxelib list:

```
haxelib list
```

To use the addons in a project simply add the following xml node to your OpenFL Project.xml file.

```
<haxelib name="flixel-addons" />
```

### Whats in the Addons

- Ports of Photonstorm's Flixel Power Tools
- Nape Physics
- Tiled editor support
- Bitmap Font
- and more