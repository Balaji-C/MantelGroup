// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import XCTest
@testable import TVMazeExplore

final class RepositoryTests: XCTestCase {
    
    var repository: Repository!
    
    override func setUp() {
        super.setUp()
        repository = Repository(networkMonitor: NetworkMonitor.shared)
    }
    
    func fileUrl(_ fileName: String) -> URL? {
        Bundle(identifier: "au.com.mantelgroup.TVMazeBrowser.TVMazeExploreTests")?.url(forResource: fileName, withExtension: nil)
    }

    func testSuccessData() async {
        
        guard let url = fileUrl("show") else { return }
        
        // Call the repository method
        let result: Result<[TVShow], Error> = await repository.requestData(url: url)
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response.count, 13, "Expected 13 shows but received \(response.count)")
        case .failure:
            XCTFail("API should succeed")
        }
    }
    
    func testFailData() async {
        
        guard let url = fileUrl("invalid") else { return }
        
        // Call the repository method
        let result: Result<[TVShow], Error> = await repository.requestData(url: url)
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response.count, 1, "Expected 1 shows but received \(response.count)")
        case .failure:
            XCTFail("API should succeed")
        }
    }
}
