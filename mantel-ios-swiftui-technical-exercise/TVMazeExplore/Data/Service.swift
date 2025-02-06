// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

protocol Service {
    func getListOfShows() async -> Result<[TVShow], Error>
    func searchForShow(searchString: String) async -> Result<[TVShow], Error>
}
