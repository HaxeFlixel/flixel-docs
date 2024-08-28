---
title: "Visual Studio Code"
---

[![](../images/00_getting_started/vscode/vscode-plus-extensions.png)](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-extension-pack)

[Visual Studio Code](https://code.visualstudio.com/) is an open-source, cross-platform, lightweight code editor by Microsoft. The [Haxe extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe) seamlessly integrates with the compiler's [IDE services](https://haxe.org/manual/cr-completion.html) and uses them for:

- Code Completion
- Go to Definition
- Go to Symbol
- Find Usages
- Finding Unused Imports
- etc...

You can find detailed documentation for the Haxe extension in the [Wiki](https://github.com/vshaxe/vshaxe/wiki), this page focuses on the Flixel-specific parts.

### Installation

- Download and install the latest version of [Visual Studio Code](https://code.visualstudio.com/).
- Go to the Extensions tab and install the [Lime extension](https://marketplace.visualstudio.com/items?itemName=openfl.lime-vscode-extension). This automatically installs the Haxe extension as well.

    ![](../images/00_getting_started/vscode/lime-installation.png)

### Project Configuration

VSCode stores its project-specific settings in a `.vscode` subfolder - [flixel-tools](http://haxeflixel.com/documentation/flixel-tools/) can create one with sensible defaults for Flixel projects. Just select VSCode as your preferred editor during the `setup` command, or add `-ide vscode` to the command you're running.

**Note:** make sure you have the latest versions of flixel-tools and flixel-templates:

```
haxelib update flixel-tools
haxelib update flixel-templates
```

You have several options for creating projects with a `.vscode` configuration:

1. Create a new, empty project:

    ```
    flixel template -n "VSCodeTest" -ide vscode
    ```

2. Create a new project based on one of the [demos](/demos):

    ```
    flixel create -ide vscode
    ```

3. Add the `.vscode` folder to a project that already exists, for instance the current working directory:

    ```
    flixel configure . -ide vscode
    ```

4. Add VSCode config files to an entire directory of projects, like flixel-demos:

    ```
    flixel configure C:\HaxeToolkit\haxe\lib\flixel-demos\git -ide vscode
    ```

### Code Completion

Once you've installed the Lime extension and have a project with a `.vscode` folder, just open it with `File` -> `Open Folder`. If the workspace was correctly detected as a Lime project (needs a `Project.xml` file), you should notice these dropdown menus appearing in the status bar:

![](../images/00_getting_started/vscode/lime-dropdowns.png)

Code completion features should work out of the box now:

![](../images/00_getting_started/vscode/completion.png)

If you're having trouble, please refer to the Haxe extension's [Troubleshooting guide](https://github.com/vshaxe/vshaxe/wiki/Troubleshooting).

### Building

Building and running your projects in VSCode is done through _tasks_. You can view the list of available tasks via `Tasks` -> `Run Task...`:

![](../images/00_getting_started/vscode/tasks.png)

To build and run your project, select the `lime: test` task. With Flixel's template, this is configured as the default build task, so you can also invoke it directly via `Tasks` -> `Run Build Task...` or by pressing `Ctrl+Shift+B`:

![](../images/00_getting_started/vscode/run-build-task.png)

You may want to assign a shortcut to `Run Task...` or change the shortcut for `Run Build Task...` to something more convenient such as `F5`. You can do so in `File` -> `Preferences` -> `Keyboard Shortcuts`.

Finally, you can change the current configuration (combination of target and Debug/Release/Final) by using the dropdown menu in the status bar:

![](../images/00_getting_started/vscode/change-config.gif)


### Compiler Errors / Problems View

By default, compiler errors and warnings are shown in the _Terminal_ view at the bottom of the screen. You can navigate to the source of the error via `Ctrl`+`Click` on the file path:

![](../images/00_getting_started/vscode/terminal.png)

Alternatively, you can switch to the _Problems_ tab which has a nicer presentation. It shows errors / warnings from compilation as well as diagnostics that are updated each time you save a file:

![](../images/00_getting_started/vscode/problems.png)

### Debugging

The `.vscode` template from flixel-tools already includes the `launch.json` needed for debugging. The Lime "Build + Debug" / "Debug" launch configurations support debugging with the following targets / extensions:

- Windows/Linux/Mac via [HXCPP Debugger](https://marketplace.visualstudio.com/items?itemName=vshaxe.hxcpp-debugger)
- HTML5 via [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome) or [Debugger for Firefox](https://marketplace.visualstudio.com/items?itemName=firefox-devtools.vscode-firefox-debug)
- Flash via [Flash Debugger](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-debug)

Simply "Start Debugging" with the "Build + Debug" launch configuration (make sure the "Debug" configuration for the target you want to debug is selected in the status bar). This first builds the project and then starts the debugger.

![](../images/00_getting_started/vscode/launch-configs.png)

Here's what it should look like when you hit a breakpoint:

<img src="../images/00_getting_started/vscode/flash-debugging.png" style="width:100%;" />

There is also a Macro launch configuration for debugging [Haxe Macros](https://haxe.org/manual/macro.html).
