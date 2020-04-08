package;

import dox.Api;
import dox.Config;
import dox.Dox;
import haxe.rtti.CType.TypeInfos;
import sys.io.File;

using StringTools;

class Main {
	public static var defines:Map<String, String>;

	static function main() {
		defines = [
			for (line in File.getContent("../xml/bin/defines.txt").split("\n")) {
				var parts = ~/ /.split(line);
				parts[0] => parts[1];
			}
		];

		var config = new Config(Macro.getDoxPath());
		config.inputPath = "../xml/bin/flash/types.xml";
		config.outputPath = "out";
		config.loadTheme("./theme");
		config.pageTitle = "HaxeFlixel API";
		config.defines = [Version => defines["flixel"]];
		config.addFilter("(__ASSET__|ApplicationMain|DocumentClass|DefaultAssetLibrary|Main|NMEPreloader|zpp_nape)", false);

		Dox.run(config, FlixelApi.new);
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
			'HaxeFoundation/haxe/blob/${Main.defines["haxe"]}/std'; // default
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

	override function hasSourceLink(type:TypeInfos):Bool {
		return type.file != null && type.file.endsWith(".hx");
	}
}
