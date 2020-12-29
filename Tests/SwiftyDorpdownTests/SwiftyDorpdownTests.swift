import XCTest
@testable import SwiftyDorpdown

final class SwiftyDorpdownTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyDorpdown().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
