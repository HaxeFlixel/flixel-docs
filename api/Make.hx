class Make {
	static function main() {
		var args = Sys.args();
		if (args.length == 0) {
			args = ["dox", "xml", "pages", "server"];
		}
		for (arg in args) {
			switch arg {
				case "xml":
					command("haxe --cwd xml xml.hxml");

				case "pages":
					Sys.setCwd("dox");
					command("npx haxe dox.hxml");
					Sys.setCwd("..");

				case "server":
					Sys.setCwd("dox/out");
					command("nekotools server");
			}
		}
	}

	static function command(cmd:String) {
		var exitCode = Sys.command(cmd);
		if (exitCode != 0) {
			Sys.exit(exitCode);
		}
	}
}
