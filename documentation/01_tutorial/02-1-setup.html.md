```
title: "1 - Setup"
```

The first things we need to do is install all of the components we need to work with HaxeFlixel. These are:

* Haxe
* Lime
* OpenFL
* HaxeFlixel
* FlashDevelop
* Flash Debug Player

There is a more verbose explanation on installing many of these things [here](http://www.openfl.org/documentation/setup/). If anything goes wrong, check there for more information.

1. Go to http://haxe.org/download and download the installer for your platform (Windows, Mac, or Linux). Run it to install Haxe.

2. Next, open up a command prompt. On Windows, you can go to `Start > Run`, type "cmd" and hit Enter.

3. In the command prompt, enter the following commands (one at a time):

  ```bash
  haxelib install flixel
  haxelib install flixel-tools
  haxelib run lime setup
  lime setup windows
  lime setup android
  ```

4. This next command will prompt you to create an command alias and select your default editor. Type and enter 'y' to accept an alias and '1' to choose FlashDevelop as your editor. Selecting '3' for 'None' will not produce a `.hxproj` file when creating a new project from a template. 

  ```
  haxelib run flixel-tools setup
  ```

5. Next, download and install the latest version of [FlashDevelop](http://www.flashdevelop.org/).

6. Finally, head over [here](http://www.adobe.com/support/flashplayer/downloads.html) and download and install the
Flash Debug Player (scroll down and choose "Download the Flash Player projector content debugger").

Assuming everything went smoothly, you should be all set - now we can actually get to the fun part and start coding!
