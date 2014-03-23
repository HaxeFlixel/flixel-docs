```
title: "Code Contributions"
```

Contributing code to HaxeFlixel is done all through the official git repositories on [GitHub](http://www.github.com/haxeflixel) 

### Use the Dev branches

All the repositories use a except the [website](https://github.com/HaxeFlixel/haxeflixel.com) and [documentation](https://github.com/HaxeFlixel/flixel-docs) use a `dev` branch which is the main entry point for features and bugfixes to accepted into the codebase. When the code is tested by the community it is then merged into master and released on haxelib.

To clarify `dev` branch on [flixel-addons](https://github.com/HaxeFlixel/flixel-addons) and [flixel-demos](https://github.com/HaxeFlixel/flixel-demos) is only compatible with the `dev` branch of [flixel](https://github.com/HaxeFlixel/flixel).

If you are making changes to the codebase that could include breaking changes or a new api, we make use of the pull request feature and suggest developers use a feature branch model. [Feature banches](https://www.atlassian.com/git/workflows#!workflow-feature-branch) are simply new branches with your code that are named with a title relating to your code.


### Merge Approval

Before a major feature is merged into core our general workflow is to get approval from a [core-contributor](https://github.com/orgs/HaxeFlixel/members) with push access.

If it is hard to get consensus on a major change all developers involved agree the original author of this project (Beeblerox) has the more important vote.

Developers do have limited time so keep in mind some simple steps to get your pull request accepted:

- Clearly describe your use case or the problem/issue your code is developed for.
- Conduct as much testing as possible on the supported targets of HaxeFlixel. If the code is for a specific target only make a clear note for developers to test.
- Provide a link to a working, compilable demo of your code.
