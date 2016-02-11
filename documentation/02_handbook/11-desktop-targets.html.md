```
title: "Desktop Targets"
```

The desktop targets of HaxeFlixel run on all mainstream operating systems (OSX, Windows and Linux). They are all compiled to C++ through the Hxcpp library and are rendered through interfacing with the [Simple DirectMedia Layer.](http://libsdl.org) The code for this part of the library is developed through [NME ](https://github.com/haxenme/NME)which provides dll libs that openfl interfaces with.

The biggest advantage of desktop targets compared to web and mobile is the power of desktop CPU and GPU processors. More complex scenes, physics and number of objects rendered can give a larger creative freedom in the games you create.

Rendering in HaxeFlixel is done through the drawTiles API. OpenGL textures are used with the GPU to render Flixel sprites. This native C++ code and use of the GPU outperforms runtimes such as the Flash Player and Adobe AIR in most circumstances substantially.

### Conditionals

```
#if cpp
//your desktop code
#end

#if desktop
//your desktop code
#end
```

### Project XML Settings

Desktop platforms can use a window width and height of 0, which is a special value that uses the full resolution of the current display.

```xml
<window width="0" height="0" background="#FFFFFF" fps="60" />
```

OpenFL also exposes the following specific settings for the desktop target:

```xml
<window hardware="true" allow-shaders="true" require-shaders="true" if="cpp"/>
<window vsync="true" antialiasing="4" if="cpp" />
<window orientation="portrait" /> || <window orientation="landscape" if="cpp"/>
```

### Compile Commands

Sublime Text, Flash Develop and IntelliJ IDEA support CPP desktop compilation through their GUI.

#### Command Line

The basic command to compile and test a native desktop target:

```
lime test windows
lime test mac
lime test linux -64
```

Run this command from the root folder of your project, the default project.xml will be used automatically. Using the test command will automatically launch the application created.
