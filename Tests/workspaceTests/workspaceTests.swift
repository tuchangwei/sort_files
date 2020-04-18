import XCTest
@testable import workspace

final class workspaceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(workspace().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
