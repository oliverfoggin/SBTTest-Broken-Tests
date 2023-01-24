import XCTest
import SBTUITestTunnelClient

final class SBTTestUITests: XCTestCase {
	private var versionLabel: XCUIElement { app.staticTexts["Hello, how are you"].firstMatch }

	func testVersionsThing() {
		app.launchTunnel { [weak self] in
			let base_url = "http://0.0.0.0:9292" // <-- I have a mock server for this URL
			let path = "/versions" // <-- I can see this endpoint hitting my mock server not being stubbed
			let complete_url = base_url + path
			let method = "GET"
			let status_code = 200

			let requestMatch = SBTRequestMatch(url: complete_url, method: method)
			let response = SBTStubResponse(fileNamed: "mockVersions.json", returnCode: status_code)

			self?.app.stubRequests(matching: requestMatch, response: response)
		}

		versionLabel.waitForExistence(timeout: .infinity)
	}
}
