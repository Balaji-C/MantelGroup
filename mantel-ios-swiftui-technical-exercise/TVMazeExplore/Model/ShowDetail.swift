// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import Foundation

struct ShowDetail: Identifiable, Equatable {
    let id = UUID()
    let showName: String
    let schedule: String
    let year: String
    let timeSlot: String
    let genres: String
    let description: String
    let imageURLString: String
    let rating: String
}
