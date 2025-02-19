// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

struct TVShow: Codable {
    let id: Int
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, externals, image, summary, updated
        case links = "_links"
    }
    
    struct Schedule: Codable {
        let time: String
        let days: [String]
    }

    struct Rating: Codable {
        let average: Double?
    }

    struct Network: Codable {
        let id: Int
        let name: String
        let country: Country?
        let officialSite: String?
    }

    struct Country: Codable {
        let name: String
        let code: String
        let timezone: String
    }

    struct Externals: Codable {
        let tvrage: Int?
        let thetvdb: Int?
        let imdb: String?
    }

    struct Image: Codable {
        let medium: String
        let original: String
    }

    struct Links: Codable {
        let selfLink: Link
        let previousepisode: Link?
        
        enum CodingKeys: String, CodingKey {
            case selfLink = "self"
            case previousepisode
        }
    }

    struct Link: Codable {
        let href: String
        let name: String?
    }
}
