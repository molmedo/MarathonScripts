import Files

func testTemplate(withFileName fileName: String) -> String
{
	return """
	import XCTest
	@testable import idealista

	class \(fileName): XCTestCase
	{
		override func setup()
		{
			super.setup()
		}

		override func tearDown()
		{
			super.tearDown()
		}
	}
	"""
}

var filesNames = [String]()

for argument in CommandLine.arguments.dropFirst() {
	filesNames.append(argument)
}

let folder = try Folder(path: "../Tests")

try filesNames.forEach {
	let file = try folder.createFile(named: String(format: "%@.swift", $0))
	let template = testTemplate(withFileName: $0)
	try file.write(string: template)
}

