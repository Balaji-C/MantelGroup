// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import XCTest
@testable import TVMazeExplore

class MockService: Service {
    var resultToReturn: Result<[TVShow], Error>?
    
    func getListOfShows() async -> Result<[TVShow], Error> {
        return resultToReturn ?? .failure(NetworkError.unknown)
    }
    
    func searchForShow(searchString: String) async -> Result<[TVShow], Error> {
        return resultToReturn ?? .failure(NetworkError.unknown)
    }
}
