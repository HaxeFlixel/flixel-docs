package;

#if macro
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;

class Macro {
	static function run() {
		FileSystem.createDirectory("bin");
		File.saveContent("bin/defines.txt", [for (key => value in Context.getDefines()) '$key $value'].join("\n"));
	}
}
#end
