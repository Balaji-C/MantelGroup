// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import XCTest
@testable import TVMazeExplore

final class EndPointTests: XCTestCase {
    
    func testSearchEndpointURL() {
        // Arrange
        let searchString = "Breaking Bad"
        let endpoint = EndPoint.search(searchString)
        
        // Act
        let url = endpoint.url
        
        // Assert
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "api.tvmaze.com")
        XCTAssertEqual(url.path, "/shows")
        XCTAssertEqual(url.query, "q=Breaking%20Bad")
    }
    
    func testShowEndpointURL() {
        // Arrange
        let endpoint = EndPoint.show
        
        // Act
        let url = endpoint.url
        
        // Assert
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "api.tvmaze.com")
        XCTAssertEqual(url.path, "/shows")
        XCTAssertNil(url.query) // No query items expected
    }
    
    func testLocalURLForSearch() {
        // Arrange
        let endpoint = EndPoint.search("Breaking Bad")
        
        // Act
        let localUrl = endpoint.localUrl
        
        // Assert
        XCTAssertNotNil(localUrl, "Local URL should not be nil for search endpoint")
        XCTAssertTrue(localUrl.lastPathComponent == "search.json")
    }
    
    func testLocalURLForShow() {
        // Arrange
        let endpoint = EndPoint.show
        
        // Act
        let localUrl = endpoint.localUrl
        
        // Assert
        XCTAssertNotNil(localUrl, "Local URL should not be nil for show endpoint")
        XCTAssertTrue(localUrl.lastPathComponent == "show.json")
    }
}
