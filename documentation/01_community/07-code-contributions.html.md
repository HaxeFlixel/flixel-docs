```
title: "Code Contributions"
```

Contributing code to HaxeFlixel is done all through the official git repositories on [GitHub](http://www.github.com/haxeflixel).

###Use the Dev branches

All repositories except the [website](https://github.com/HaxeFlixel/haxeflixel.com) and [documentation](https://github.com/HaxeFlixel/flixel-docs) use a `dev` branch which is the main entry point for features and bugfixes to accepted into the codebase. When the code is tested by the community it is then merged into master and released on haxelib.

To clarify: the `dev` branch on [flixel-addons](https://github.com/HaxeFlixel/flixel-addons) and [flixel-demos](https://github.com/HaxeFlixel/flixel-demos) is only compatible with the `dev` branch of [flixel](https://github.com/HaxeFlixel/flixel).

If you are making changes to the codebase that could include breaking changes or a new API, we make use of the pull request feature and suggest developers use a feature branch model. [Feature branches](https://www.atlassian.com/git/workflows#!workflow-feature-branch) are simply new branches with your code that are named with a title relating to your code.

###Merge Approval

Before a major feature is merged into core our general workflow is to get approval from a [core-contributor](https://github.com/orgs/HaxeFlixel/people) with push access.

Developers do have limited time so keep in mind some simple steps to get your pull request accepted:

- Clearly describe your use case or the problem/issue your code is developed for.
- Conduct as much testing as possible on the supported targets of HaxeFlixel. If the code is for a specific target only make a clear note for developers to test.
- Provide a link to a working, compilable demo of your code.

###Contribute to the stack

Everything about the technology stack of HaxeFlixel is open-source so you can contribute directly to the language, compiler and upstream libraries:

- The language it uses [Haxe](https://github.com/Haxefoundation/haxe)
- The framework it is built upon: [OpenFL](https://github.com/openfl/openfl) and [Lime](https://github.com/openfl/lime)
- The core engine [flixel](https://github.com/HaxeFlixel/flixel)
- Addons/Plugins to the core engine [addons](https://github.com/HaxeFlixel/flixel-addons) | [ui](https://github.com/HaxeFlixel/flixel-ui)
- The official [Demos](https://github.com/HaxeFlixel/flixel-demos)
- The [Flixel Tools](https://github.com/HaxeFlixel/flixel-tools)
- [Project Templates](https://github.com/HaxeFlixel/flixel-templates)
- This [documentation](https://github.com/HaxeFlixel/flixel-docs)
- The website [haxeflixel.com](https://github.com/HaxeFlixel/haxeflixel.com)

If you are wanting to contribute code, please review the [code style](http://haxeflixel.com/documentation/code-style) and [code-contributions](http://haxeflixel.com/documentation/code-contributions) pages.

