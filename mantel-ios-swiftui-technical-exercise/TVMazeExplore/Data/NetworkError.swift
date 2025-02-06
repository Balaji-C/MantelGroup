// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

enum NetworkError: Error {
    case noInternet
    case invalidResponse
    case invalidFormat
    case unknown
    
    var errorMessage: String {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .invalidResponse, .invalidFormat:
            return "Invalid response"
        case .unknown:
            return "Something wrong. Please try again"
        }
    }
}
