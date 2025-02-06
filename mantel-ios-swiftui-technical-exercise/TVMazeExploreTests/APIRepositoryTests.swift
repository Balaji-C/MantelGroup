// Technical exercise, Mantel Group pty ltd.
// Created on 27/1/2025.

import XCTest
@testable import TVMazeExplore

final class APIRepositoryPreviewTests: XCTestCase {
    var repository: APIRepository!

    override func setUp() {
        super.setUp()
        repository = APIRepository(networkMonitor: NetworkMonitor.shared)
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    func testGetListOfShows_ReturnsMockData() async throws {
        let result = await repository.getListOfShows()
        switch result {
        case .success(let shows):
            XCTAssertFalse(shows.isEmpty, "Expected non-empty mock data")
            XCTAssertEqual(shows.first?.name, "Under the Dome")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testSearchForShow_ReturnsMockData() async throws {
        let searchQuery = "Mock Query"

        let result = await repository.searchForShow(searchString: searchQuery)
        switch result {
        case .success(let shows):
            XCTAssertFalse(shows.isEmpty, "Expected non-empty mock data")
            XCTAssertEqual(shows.first?.name, "Under the Dome")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
}
