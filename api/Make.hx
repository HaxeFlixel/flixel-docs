class Make {
	static function main() {
		for (arg in Sys.args()) {
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
