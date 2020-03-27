import haxe.io.Path;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.Process;

using StringTools;

class Macro {
	// meh...
	public macro static function getDoxPath():Expr {
		var output = getProcessOutput('npx haxelib path dox');
		for (line in output.split("\n")) {
			if (FileSystem.exists(line)) {
				var path = Path.directory(Path.removeTrailingSlashes(line.trim()));
				return macro $v{path};
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
