package;

import dox.Api;
import dox.Config;
import dox.Dox;
import haxe.io.Path;
import haxe.rtti.CType.TypeInfos;
import sys.FileSystem;
import sys.io.Process;

using StringTools;

class Main {
	static function main() {
		var config = new Config();
		config.inputPath = "../xml/bin/flash/types.xml";
		config.outputPath = "out";
		config.loadTheme(getDoxPath(), "./theme");
		config.pageTitle = "HaxeFlixel API";
		config.defines = [Version => "4.6.3"];
		config.addFilter("(__ASSET__|ApplicationMain|DocumentClass|DefaultAssetLibrary|Main|NMEPreloader|zpp_nape)", false);

		Dox.run(config, FlixelApi.new);
	}

	// meh...
	static function getDoxPath():String {
		var output = getProcessOutput('npx haxelib path dox');
		for (line in output.split("\n")) {
			if (FileSystem.exists(line)) {
				return Path.directory(Path.removeTrailingSlashes(line.trim()));
			}
		}
		throw "dox path not found";
	}

	static function getProcessOutput(cmd:String, ?args:Array<String>):String {
		try {
			var process = new Process(cmd, args);
			var output = "";

			try {
				output = process.stdout.readAll().toString();
			} catch (_:Dynamic) {}

			process.close();
			return output;
		} catch (_:Dynamic) {
			return "";
		}
	}
}

class FlixelApi extends Api {
	override function getSourceLink(type:TypeInfos):Null<String> {
		var module = type.module != null ? type.module : type.path;
		var ending = ".hx";
		var url = "https://github.com/" + if (module.startsWith("flixel.addons.ui")
			&& !isOneOf(module, ["FlxButtonPlus", "FlxClickArea", "FlxSlider"])) {
			"HaxeFlixel/flixel-ui/tree/master";
		} else if (module.startsWith("flixel.addons")) {
			"HaxeFlixel/flixel-addons/tree/master";
		} else if (module.startsWith("flixel")) {
			"HaxeFlixel/flixel/tree/master";
		} else if (module.startsWith("nape") || module.startsWith("zpp_nape")) {
			ending = ".cx";
			"deltaluca/nape/tree/master/cx-src";
		} else if (module.startsWith("spinehaxe")) {
			"bendmorris/spinehaxe/tree/master";
		} else if (module.startsWith("openfl")) {
			module = module.substr(module.indexOf("."));
			"openfl/openfl/tree/master/src/openfl";
		} else if (module.startsWith("lime")) {
			"openfl/lime/tree/master/src";
		} else if (module.startsWith("hscript")) {
			"HaxeFoundation/hscript/tree/master";
		} else {
			"HaxeFoundation/haxe/tree/master/std"; // default
		}

		return haxe.io.Path.join([url, module.replace(".", "/") + ending]);
	}

	function isOneOf(module:String, classes:Array<String>):Bool {
		for (cl in classes) {
			if (module.indexOf(cl) >= 0)
				return true;
		}
		return false;
	}

	override function hasSourceLink():Bool {
		return true;
	}
}
