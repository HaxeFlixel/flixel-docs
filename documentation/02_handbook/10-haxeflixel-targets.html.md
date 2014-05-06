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

While HTML5 support is still somewhat experimental, thanks to great work that has been placed towards advancing the target much further, it is now possible to achieve more than reasonable results with both available backends: [openfl-bitfive](https://github.com/YellowAfterlife/openfl-bitfive), that serves as default, and [openfl-html5](https://github.com/openfl/openfl-html5) which you can use by adding this line to your project.xml (**before Flixel's libraries!**):
```xml 
<haxelib name="openfl-html5"/>
```

**_Here are some simple guidelines to get you started:_**

#### General HaxeFlixel's HTML5 Guidelines
- **Text**: For now, you might prefer using [bitmap fonts](http://haxeflixel.com/demos/FlxBitmapTextField/) to avoid text issues. With regular fonts, you may favor larger text size (>12) in order to avoid blurriness, and try some [manual adjustments](https://github.com/HaxeFlixel/flixel/issues/1024) if you have a scaling problem (or when you are trying to embed fonts, which is not supported).
- **Audio**: You should use regular .ogg files (see the backends sections for more details).
- **Particles**: You should keep the particle count low and not expect much in terms of performance.

#### openfl-bitfive Guidelines 
- **Audio**: For now, you can only use .wav files on Firefox (.ogg is not supported there). Music does not loop on Chrome when running your game via nekotools server.
- **Scale**: openfl-bitfive fills the entire browser window with your game, mirroring the behaviour of a .swf file when opened directly in the browser. To avoid this, embed your game in an iframe.

#### openfl-html5 Guidelines
- **Graphics**: Graphics on this backend might have a certain blur compared to openfl-bitfive rendering.
- **Audio**: Though .mp3 and .wav files are supported, SoundJS may not recognise them and might stop your project from running until you delete/replace them.