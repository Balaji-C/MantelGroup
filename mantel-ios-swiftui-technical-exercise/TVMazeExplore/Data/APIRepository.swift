// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

class APIRepository: Repository, Service {
    func getListOfShows() async -> Result<[TVShow], Error> {
        if isPreview {
            return await DataHelper.populateTemporaryDataForPreview()
        }
        
        return await requestData(url: EndPoint.show.url)
    }
    
    func searchForShow(searchString: String) async -> Result<[TVShow], Error> {
        if isPreview {
            return await DataHelper.populateTemporaryDataForPreview()
        }
        
        return await requestData(url: EndPoint.search(searchString).url)
    }
}
