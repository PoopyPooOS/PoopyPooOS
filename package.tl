let cargo = toml(readFile("./Cargo.toml"))
let package = cargo.package

let name = package.name

{
	id = name
	version = package.version
	description = "Core system package"

	src = "."
	expected_output = [
		"/"
	]

	build = "cargo build --release --workspace"
	install = "echo todo; exit 1"
}
