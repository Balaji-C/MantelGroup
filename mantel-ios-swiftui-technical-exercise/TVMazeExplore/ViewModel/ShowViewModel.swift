// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI
import Combine

class ShowViewModel: ObservableObject {
    let service: Service
    let session = URLSession(configuration: .default)
    
    @Published var shows: [ShowDetail] = []
    @Published var isLoading = true
    @Published var errorMessage: String? = nil
    
    private enum WeekDays: String, CaseIterable {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
    }
    
    private enum Weekends: String, CaseIterable {
        case Saturday
        case Sunday
    }
    
    init(service: Service) {
        self.service = service
        Task {
            await fetchShows(searchString: "")
        }
    }
    
    func fetchShows(searchString: String) async {
        let result: Result<[TVShow], Error>
        
        if searchString.isEmpty {
            result = await service.getListOfShows()
        } else {
            result = await service.searchForShow(searchString: searchString)
        }
        await MainActor.run {
            switch result {
            case .success(let response):
                self.shows = getShowsList(shows: response)
            case .failure(let error):
                guard let message = (error as? NetworkError)?.errorMessage else { return }
                self.errorMessage = message
            }
            isLoading = false
        }
    }
    
    func resetData() {
        shows =  []
        isLoading = true
    }
}

extension ShowViewModel {
    func getShowsList(shows: [TVShow]) -> [ShowDetail] {
        var showDetails = [ShowDetail]()
        for show in shows {
            let days:[String] = show.schedule?.days ?? []
            var schedule = ""
            var year = ""
            var genres = ""
            var averageRating = ""
            let scheduleTime = show.schedule?.time ?? ""
            
            
            if let time = show.schedule?.time, !time.isEmpty {
                schedule = getScheduleDescription(for: TVShow.Schedule(time: time, days: days))
            }
            
            if let premieredDate = show.premiered, !premieredDate.isEmpty {
                year = getPremieredYear(dateString: premieredDate)
            }
            
            if let types = show.genres {
                genres = types.joined(separator: ",")
            }
                        
            if let rating = show.rating?.average {
                averageRating = String("Average Rating:\(rating)")
            }
            
            let showDetail = ShowDetail(showName: show.name ?? "",
                                        schedule: schedule,
                                        year: year,
                                        timeSlot: scheduleTime,
                                        genres: genres,
                                        description: show.summary ?? "",
                                        imageURLString: show.image?.medium ?? "",
                                        rating: averageRating)
            showDetails.append(showDetail)
        }
        return showDetails
    }
    
    func getScheduleDescription(for schedule: TVShow.Schedule) -> String {
        let prefix = getPrefix(from: schedule.time)
        let dayDescriptor = getDayDescriptor(from: schedule.days)
        let timeDescriptor = getTimeDescriptor(from: schedule.time)
        let components = [prefix, dayDescriptor, timeDescriptor].compactMap { $0 }
        return components.joined(separator: " ")
    }
    
    func getPrefix(from time: String) -> String? {
        guard let hour = Int(time.prefix(2)),
              let minute = Int(time.suffix(2)), (0...59).contains(minute) else { return nil }
        if hour >= 0 && hour < 6 {
            return "Early"
        }
        return nil
    }
    
    func getDayDescriptor(from days: [String]) -> String? {
        
        let weekdays = WeekDays.allCases.map { $0.rawValue }
        let weekends = Weekends.allCases.map { $0.rawValue }
        let allDays = weekdays + weekends
        
        let daySet = Set(days)
        if daySet == Set(weekdays) {
            return "Weekday"
        } else if daySet == Set(weekends) {
            return "Weekend"
        } else if daySet == Set(allDays) {
            return nil
        } else {
            return days.joined(separator: ", ")
        }
    }
    
    func getTimeDescriptor(from time: String) -> String? {
        guard let hour = Int(time.prefix(2)), let minute = Int(time.suffix(2)), (0...59).contains(minute) else {
            return nil
        }
        
        switch hour {
        case 1..<12:
            return "Mornings"
        case 13..<18:
            return "Afternoons"
        case 18..<24:
            return "Nights"
        default:
            return nil
        }
    }
    
    func getPremieredYear(dateString: String) -> String {
        var year = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            year = String(Calendar.current.component(.year, from: date))
        }
        return year
    }
}
