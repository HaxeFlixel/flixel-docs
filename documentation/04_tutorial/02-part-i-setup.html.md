```
title: "Part I: Setup"
```

The first things we need to do is install all of the components we need to work with HaxeFlixel. These are:

- Haxe
- Lime
- OpenFL
- HaxeFlixel
- FlashDevelop
- Flash Debug Player

There is a more verbose explanation on installing many of these things [here](http://www.openfl.org/documentation/setup/), but I’ll walk you through it quickly. If anything goes wrong, check there for more information.

1. Goto http://haxe.org/download and download the Automatic Installer for your platform (Windows, Mac, or Linux). Run it to install Haxe.
2. Next, open up a Command Prompt. In windows, you can go to Start>Run and type "cmd" and hit Enter.
3. At the Command Prompt, enter the following commands (one at a time):
  1. ```
  haxelib install lime
  ```
  2. ```
  haxelib run lime setup
  ```
  3. ```
  lime install openfl
  ```
  4. ```
  lime setup windows
  ```
  5. ```
  lime setup android
  ```
  6. ```
  haxelib install flixel
  ```
  7. ```
  haxelib install flixel-tools
  ```
  8. ```
  haxelib run flixel-tools setup
  ```
4. Next, download and install the latest version of FlashDevelop: http://www.flashdevelop.org/
5. Finally, head over here: http://www.adobe.com/support/flashplayer/downloads.html and download and install the Flash Debug Player (scroll down and choose "Download the Windows Flash Player 13 Projector")

Assuming everything went smoothly, you should be all set! Now we can actually get to the fun part and start coding!