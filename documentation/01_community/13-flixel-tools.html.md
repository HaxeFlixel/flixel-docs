```
title: "Flixel Tools"
```

To make HaxeFlixel development easier, a set of command line tools has been developed with [Haxe](http://haxe.org) and [Neko](http://nekovm.org). With it you can easily create our demo projects, templates and more. Just like HaxeFlixel it is an open-source tool and additions/improvements from the community are welcome at the [flixel-tools GitHub repository](https://github.com/HaxeFlixel/flixel-tools).

### Installation:

The tools are available on haxelib:

```bash
haxelib install flixel-tools
```

## Setup the Tools

To set the tools up initially / to be able to use the `flixel` alias in your console:

```bash
haxelib run flixel-tools setup
```

## Commands

### `create` (`c`)

Create a new demo (in the current directory):

```bash
flixel create <name_or_number>
```

If no name or number is given, it will list all demos and prompt you for a choice, by number or name.

### `template` (`tpl`)

To create a new project from the default template:

```bash
flixel tpl -n <name>
```

Alternatively, a `barebones` template is available. It contains no comments and only has a single state:

```bash
flixel tpl barebones -n <name>
```

Any folder in the `flixel-templates` haxelib is treated as a template and can be created with the `flixel tpl <foldername>` syntax. This makes it easy to create custom templates.
