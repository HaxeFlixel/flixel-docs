```
title: "HaxeFlixel Targets"
```

HaxeFlixel currently supports the following targets through OpenFL:

#### [Desktop](/documentation/desktop-targets)

- Windows
- Mac
- Linux

#### [Mobile](/documentation/mobile-targets)

- [IOS](/documentation/ios)
- [Android](/documentation/android)
- Blackberry
- WebOS

#### Web

- Flash

Using these targets requires the appropriate SDK's and system setup assisted through the OpenFL setup commands.

```
openfl setup windows
openfl setup mac
openfl setup android
openfl setup blackberry
```


### HTML5

While Html5 support is still somewhat experimental, thanks to great work that has been placed towards advancing the target much further, it is now possible to achieve more than reasonable results with both available backends: [openfl-bitfive](https://github.com/YellowAfterlife/openfl-bitfive), that serves as default, and [openfl-html5](https://github.com/openfl/openfl-html5) which you can use by adding this line to your project.xml (**before Flixel's libraries!**):
```xml 
<haxelib name="openfl-html5"/>
```

**_Here are some simple guidelines to get you started:_**

#### General HaxeFlixel's Html5 Guidelines
- **Text**: For now, you might prefer using [bitmap fonts](http://haxeflixel.com/demos/FlxBitmapTextField/) to avoid text issues. With regular fonts, you may favor larger text size (>12) in order to avoid blurriness, and try some [manual adjustments](https://github.com/HaxeFlixel/flixel/issues/1024) if you have a scaling problem (or when you are trying to embed fonts, which is not supported).
- **Audio**: You should use regular OGG files (see the backends sections for more details).
- **Particles**: You should only use simple particles, and not expect much in terms of performance.

#### openfl-bitfive Guidelines 
- **Audio**: For now, you can only use WAV files on Firefox (OGG is not supported there), and you should keep in mind that music (i.e. OGG files) does not loop on Chrome (when running your game via nekotools server).
- **Scale**: openfl-bitfive fills the entire browser window with your game, so you should embed your game in an iframe, like you would with Flash, so you can avoid scaling issues.

#### openfl-html5 Guidelines
- **Graphics**: Graphics on this backend may be rendered "flat", i.e with a certain blur as compared with openfl-bitfive rendering.
- **Audio**: Though MP3 and WAV files are supported, SoundJS may not recognise them and might stop your project from running until you delete/replace them.