import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PublishColorUtilsTests.allTests),
    ]
}
#endif
