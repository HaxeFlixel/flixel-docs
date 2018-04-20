```
title: "Why a Haxe Version"
```

The original ActionScript 3 version of [Flixel](http://flixel.org) has proven to be an effective codebase to make 2D games quickly and easily for the Adobe Flash and AIR runtimes. [Haxe](http://haxe.org) and the [Open Flash Library](https://github.com/openfl) provide significant enhancements and opportunities that ActionScript 3, AIR and Flash are limited by. [Haxe](http://haxe.org) and the [OpenFL](https://github.com/openfl) offers more efficient and open source native runtimes to your code base that ActionScript 3 and Adobe Flash/Air are not able to provide. HaxeFlixel still retains the same Flash Player target, but you gain a[ familiar, yet superior](http://www.openfl.org/archive/developer/documentation/actionscript-developers/) open source language [Haxe](http://haxe.org).

#### Use of a superior open source, cross-compiled language

Haxe as a toolkit and language provides features today that ActionScript developers have been seeking for years (ActionScript 4, cancelled code name "Next" compiler). The language ActionScript 3, although proven to be effective and easy to learn, can be a barrier itself.

The Haxe language offers a familiar syntax whilst being able to cross-compile to different target languages such as native C++, Neko, HTML5, PHP, Java and more. For example OpenFL is letting you target Linux natively where Adobe has discontinued their AIR support some time ago.

Haxe still lets you target Flash and AIR runtimes, whilst also opening the doors to much more. You gain the benefits of a superior language and open source runtime. For example,  C++ works with OpenFL and [LibSDL](http://www.libsdl.org/), which would not be possible with Adobe's workflow. HaxeFlixel is far from the only ActionScript library being ported to Haxe. [HaxePunk](http://haxepunk.com/) and other projects can be found on [GitHub](https://github.com/languages/Haxe) and [haxelib](http://lib.haxe.org/).

#### Native Targets are not a Virtual Machine

Haxe is a cross-compiled language which is unlike solutions such as Adobe Air that use a virtual machine to run on different platforms. When you compile your Haxe code to a native target, it is translated into the native language itself, such as C++. Native code running on your target runtime does not share the same overheads in performance that a virtual machine has, so your code is often much faster in comparison. HaxeFlixel also takes advantage of OpenFL's use of GPU accelerated rendering through their drawTiles api.

#### Open Source Extendible Framework

By using the Haxe Toolkit and OpenFL, advanced developers can extend and modify anything in the toolchain right down from the compiler and the native runtime code such as HXCPP and SDL. The developers and the community behind these tools have shown a constant improvement to the projects over many years. History has shown commercial solutions do not always prioritize developer requests, and even advanced developers can't just fix their issues or bugs they find themselves.

The source code for everything in the toolchain is available on GitHub:

*   [HaxeFlixel on GitHub](https://github.com/HaxeFlixel)
*   [OpenFL on GitHub](https://github.com/openfl)
*   [HaxeFoundation on GitHub](https://github.com/haxefoundation)
