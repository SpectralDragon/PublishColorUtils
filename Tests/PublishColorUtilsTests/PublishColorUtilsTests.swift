import XCTest
@testable import PublishColorUtils

final class PublishColorUtilsTests: XCTestCase {
    func testExample() {
        
        // Hex
        XCTAssertEqual(Color(hex: "#ff3b30").hex, "#ff3b30".uppercased())
        
        // RGBA css representation
        XCTAssertEqual(Color(hex: "#ff3b30").rgbaDescription, "rgba(255, 59, 48, 1)")
        
        // Hex with alpha and custom opacity
        XCTAssertEqual(Color(hex: "#ff3b30").opacity(0.3).rgbaDescription, "rgba(255, 59, 48, 0.3)")
        
        // Hex with alpha
        XCTAssertEqual(Color(hex: "#ff3b30").hexWithAlpha, "#ff3b30ff".uppercased())
        
        // RGB and hex
        XCTAssertEqual(Color(red: 255/255, green: 59/255, blue: 48/255).hex, "#ff3b30".uppercased())
        
        // Equatable
        XCTAssertEqual(Color(red: 255/255, green: 59/255, blue: 48/255), Color(hex: "#ff3b30"))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
