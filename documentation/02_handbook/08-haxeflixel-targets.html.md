---
title: "HaxeFlixel Targets"
---

HaxeFlixel currently supports the following targets through OpenFL:

#### [Desktop](/documentation/desktop-targets)

- Windows
- Mac
- Linux

#### [Mobile](/documentation/mobile-targets)

- [iOS](/documentation/ios)
- [Android](/documentation/android)

#### Web

- Flash
- HTML5

Using these targets requires the appropriate SDK's and system setup assisted through the Lime setup commands.

```
lime setup windows
lime setup mac
lime setup android
```

### HTML5

#### General HTML5 Guidelines
- **Text**: For now, you might prefer using [bitmap fonts](https://haxeflixel.com/demos/FlxBitmapText/) to avoid text issues. With regular fonts, you may favor larger text size (>12) in order to avoid blurriness, and try some [manual adjustments](https://github.com/HaxeFlixel/flixel/issues/1024) if you have a scaling problem (or when you are trying to embed fonts, which is not supported).
- **Audio**: You should use regular .ogg files . Though .mp3 and .wav files are supported, SoundJS may not recognise them and might stop your project from running until you delete/replace them.
- **Particles**: You should keep the particle count low and not expect much in terms of performance.
