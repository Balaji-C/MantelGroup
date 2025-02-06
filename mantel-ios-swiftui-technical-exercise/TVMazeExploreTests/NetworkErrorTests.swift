// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import XCTest
@testable import TVMazeExplore

class NetworkErrorTests: XCTestCase {
    
    func testNoInternetErrorMessage() {
        let error: NetworkError = .noInternet
        let message = error.errorMessage
        XCTAssertEqual(message, "No internet connection", "Error message for 'noInternet' should be 'No internet connection'")
    }
    
    func testInvalidResponseErrorMessage() {
        let error: NetworkError = .invalidResponse
        let message = error.errorMessage
        XCTAssertEqual(message, "Invalid response", "Error message for 'invalidResponse' should be 'Invalid response'")
    }
    
    func testInvalidFormatErrorMessage() {
        let error: NetworkError = .invalidFormat
        let message = error.errorMessage
        XCTAssertEqual(message, "Invalid response", "Error message for 'invalidFormat' should be 'Invalid response'")
    }
    
    func testUnknownErrorMessage() {
        let error: NetworkError = .unknown
        let message = error.errorMessage
        XCTAssertEqual(message, "Something wrong. Please try again", "Error message for 'unknown' should be 'Something wrong. Please try again'")
    }
}
