class Make {
	static function main() {
		var args = Sys.args();
		if (args.length == 0) {
			args = ["dox", "xml", "pages", "server"];
		}
		for (arg in args) {
			switch arg {
				case "xml":
					Sys.command("haxe --cwd xml xml.hxml");

				case "pages":
					Sys.setCwd("dox");
					Sys.command("npx haxe dox.hxml");
					Sys.setCwd("..");

				case "server":
					Sys.setCwd("dox/out");
					Sys.command("nekotools server");
			}
		}
	}
}
