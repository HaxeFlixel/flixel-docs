```
title: "Tips and Tricks"
```
This is a collection of various tips and tricks for developing with HaxeFlixel.

## Overriding SWF Script Timeout

By default, Flash will create a dialog box and cancel any running scripts after 15 seconds spent in a single loop. Generally, this is good as it helps to prevent a Flash file from being stuck in an infinite loop, but there are times where you may wish to override this preset. Haxe offers a [compilation flag](http://haxe.org/manual/tips_and_tricks) that can do just this, and OpenFL can pass this to the compiler by adding the following line to your [Project.XML](documentation/openfl-project-xml-format/) file:

``` xml
<haxeflag name="-D" value="swf-script-timeout=60" />
```

Where '60' can be any value from 15 to 60, and is the number of seconds that elapse before the dialog appears. 60 is the hard-coded limit and is the maximum value that can be used for this flag. If you use a value higher than 60, the limit will be set to 60. Please note that regardless of the limit you set, the dialog warning will still read `A script has executed for longer than the default timeout period of 15 seconds.`

## Enable system Flash Player in Google Chrome | Windows | Mac
Flash Player is integrated with Google Chrome as Pepper plug-in (PPAPI). Some flash builds will fail to run in chrome when using the HaxeFlixel preloader and other scenarios.

If you have installed Flash Player using Mozilla Firefox or Safari, Google Chrome displays it in the plug-in list. You can enable this plug-in in Chrome.

Follow the link below to change your flash player in chrome.

http://helpx.adobe.com/flash-player/kb/enable-system-flash-player-google-chrome.html
