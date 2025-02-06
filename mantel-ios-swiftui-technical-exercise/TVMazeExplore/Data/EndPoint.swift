// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import Foundation

enum EndPoint {
    case search(_ searchString: String)
    case show
    
    private var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.tvmaze.com"
        return components
    }
    
    var url:URL {
        switch self {
        case .search(let searchString):
            generateURL(path: "/shows", queryItems: [URLQueryItem(name: "q", value: searchString)])
        case .show:
            generateURL(path: "/shows", queryItems:[])
        }
    }
    
    var localUrl: URL {
        switch self {
        case .search:
            fileUrl("search.json")!
        case .show:
            fileUrl("show.json")!
        }
    }
    
    private func generateURL(path: String, queryItems: [URLQueryItem]) -> URL {
        var components = baseURL
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            fatalError("Failed to create URL for path: \(path)")
        }
        return url
    }
    
    private func fileUrl(_ fileName: String) -> URL? {
        Bundle(identifier: "au.com.mantelgroup.TVMazeBrowser.TVMazeExplore")?.url(forResource: fileName, withExtension: nil)
    }
}
