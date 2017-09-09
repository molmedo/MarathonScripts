import Files

func viewTemplate(withFileName fileName: String) -> String
{
	let completeName = String(format: "%@ViewController", fileName)

	return """
	import UIKit

	class \(completeName): UIViewController
	{
		var eventHandler: \(fileName)PresenterInterface!

		override func viewDidLoad()
		{
			super.viewDidLoad()

			eventHandler.viewLoaded()
		}
	}

	extension \(completeName): \(fileName)View
	{

	}
	"""
}

func viewInterfaceTemplate(withFileName fileName: String) -> String
{
	let completeName = String(format: "%@View", fileName)

	return """
	import UIKit

	protocol \(completeName): class
	{
		
	}

	"""
}

func presenterTemplate(withFileName fileName: String) -> String
{
	let completeName = String(format: "%@Presenter", fileName)

	return """

	class \(completeName)
	{
		weak var view: \(fileName)View!
		var routing: \(fileName)RoutingInterface!
	}

	extension \(completeName): \(fileName)PresenterInterface
	{
		func viewLoaded()
		{

		}
	}
	"""
}

func presenterInterfaceTemplate(withFileName fileName: String) -> String
{
	let completeName = String(format: "%@PresenterInterface", fileName)

	return """
	protocol \(completeName): class
	{
		func viewLoaded()
	}
	"""
}

func routingTemplate(withFileName fileName: String) -> String
{
	let completeName = String(format: "%@Routing", fileName)

	return """
	import UIKit

	class \(completeName)
	{
		weak var presentedViewController: UIViewController!
	}

	extension \(completeName): \(fileName)RoutingInterface
	{
		
	}
	"""
}

func routingInterfaceTemplate(withFileName fileName: String) -> String
{
	let completeName = String(format: "%@RoutingInterface", fileName)

	return """
	protocol \(completeName): class
	{
	}

	"""
}

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

var viperModuleName = CommandLine.arguments[1]
let folder = try Folder(path: "../")
let testFolder = try Folder(path: "../Tests/")

let viewFileName = String(format: "%@ViewController", viperModuleName)
let viewInterfaceFileName = String(format: "%@View", viperModuleName)
let presenterFileName = String(format: "%@Presenter", viperModuleName)
let presenterInterfaceFileName = String(format: "%@PresenterInterface", viperModuleName)
let routingFileName = String(format: "%@Routing", viperModuleName)
let routingInterfaceFileName = String(format: "%@RoutingInterface", viperModuleName)

let viewTestFileName = String(format: "%@Test", viewFileName)
let presenterTestFileName = String(format: "%@Test", presenterFileName)
let routingTestFileName = String(format: "%@Test", routingFileName)

let viewFile = try! folder.createFile(named: String(format: "%@.swift", viewFileName))
let viewInterfaceFile = try! folder.createFile(named: String(format: "%@.swift", viewInterfaceFileName))
let presenterFile = try! folder.createFile(named: String(format: "%@.swift", presenterFileName))
let presenterInterfaceFile = try! folder.createFile(named: String(format: "%@.swift", presenterInterfaceFileName))
let routingFile = try! folder.createFile(named: String(format: "%@.swift", routingFileName))
let routingInterfaceFile = try! folder.createFile(named: String(format: "%@.swift", routingInterfaceFileName))

let viewTestFile = try! testFolder.createFile(named: String(format: "%@.swift", viewTestFileName))
let presenterTestFile = try! testFolder.createFile(named: String(format: "%@.swift", presenterTestFileName))
let routingTestFile = try! testFolder.createFile(named: String(format: "%@.swift", routingTestFileName))

try viewFile.write(string: viewTemplate(withFileName: viperModuleName))
try viewInterfaceFile.write(string: viewInterfaceTemplate(withFileName: viperModuleName))
try presenterFile.write(string: presenterTemplate(withFileName: viperModuleName))
try presenterInterfaceFile.write(string: presenterInterfaceTemplate(withFileName: viperModuleName))
try routingFile.write(string: routingTemplate(withFileName: viperModuleName))
try routingInterfaceFile.write(string: routingInterfaceTemplate(withFileName: viperModuleName))

try viewTestFile.write(string: testTemplate(withFileName: viewTestFileName))
try presenterTestFile.write(string: testTemplate(withFileName: presenterTestFileName))
try routingTestFile.write(string: testTemplate(withFileName: routingTestFileName))

