// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import Foundation
@testable import TVMazeExplore

class MockRepository: Repository, Service {
    func getListOfShows() async -> Result<[TVShow], Error> {
        return await DataHelper.populateTemporaryDataForPreview()
    }
    func searchForShow(searchString: String) async -> Result<[TVShow], Error> {
        return await DataHelper.populateTemporaryDataForPreview()
    }
}
