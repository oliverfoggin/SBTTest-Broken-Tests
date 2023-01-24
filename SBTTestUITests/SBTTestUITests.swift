//
//  SBTTestUITests.swift
//  SBTTestUITests
//
//  Created by Oliver Foggin on 24/01/2023.
//

import XCTest
import SBTUITestTunnelClient

final class SBTTestUITests: XCTestCase {
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
		
		// In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
	}
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	//    func testExample() throws {
	//        // UI tests must launch the application that they test.
	//        let app = XCUIApplication()
	//        app.launch()
	//
	//        // Use XCTAssert and related functions to verify your tests produce the correct results.
	//    }
	
	//    func testLaunchPerformance() throws {
	//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
	//            // This measures how long it takes to launch your application.
	//            measure(metrics: [XCTApplicationLaunchMetric()]) {
	//                XCUIApplication().launch()
	//            }
	//        }
	//    }
	private var versionLabel: XCUIElement {
		return app.staticTexts["Hello, how are you"].firstMatch
//		return app.buttons["ok"].firstMatch
	}

	func testVersionsThing() {
		app.launchTunnel { [weak self] in
			let base_url = "http://0.0.0.0:9292" // <-- I have a mock server for this URL
			let path = "/versions" // <-- I can see this endpoint hitting my mock server not being stubbed
			let complete_url = base_url + path
			let method = "GET"
			let status_code = 200

			let requestMatch = SBTRequestMatch(url: complete_url, method: method)
			let response = SBTStubResponse(fileNamed: "mockVersions.json", returnCode: status_code)

//			print(self?.app)

			self?.app.stubRequests(matching: requestMatch, response: response)
		}

		versionLabel.waitForExistence(timeout: .infinity)
//		app.
	}
}
