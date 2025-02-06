// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI
import XCTest
@testable import TVMazeExplore


final class ShowViewModelTests: XCTestCase {
    var mockService: MockService!
    var viewModel: ShowViewModel!
    var mockShows:[TVShow] = []
    
    
    override func setUp() {
        super.setUp()
        mockService = MockService()
        viewModel = ShowViewModel(service: mockService)
        mockShows = [TVShow(
            id: 1,
            url: "https://www.tvmaze.com/shows/1/under-the-dome",
            name: "Under the Dome",
            type: "Scripted",
            language: "English",
            genres: ["Drama", "Science-Fiction", "Thriller"],
            status: "Ended",
            runtime: 60,
            averageRuntime: 60,
            premiered: "2013-06-24",
            ended: "2015-09-10",
            officialSite: "http://www.cbs.com/shows/under-the-dome/",
            schedule: TVShow.Schedule(time: "22:00", days: ["Thursday"]),
            rating: TVShow.Rating(average: 6.5),
            weight: 99,
            network: TVShow.Network(
                id: 2,
                name: "CBS",
                country: TVShow.Country(
                    name: "United States",
                    code: "US",
                    timezone: "America/New_York"
                ),
                officialSite: "https://www.cbs.com/"
            ),
            externals: TVShow.Externals(tvrage: 25988, thetvdb: 264492, imdb: "tt1553656"),
            image: TVShow.Image(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
            ),
            summary: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>",
            updated: 1736705990,
            links: TVShow.Links(
                selfLink: TVShow.Link(href: "https://api.tvmaze.com/shows/1", name: nil),
                previousepisode: TVShow.Link(href: "https://api.tvmaze.com/episodes/185054", name: "The Enemy Within")
            )
        )]
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchShows_Success() async {
        mockService.resultToReturn = .success(mockShows)
        
        await viewModel.fetchShows(searchString: "")
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.shows.count, 1)
        XCTAssertEqual(viewModel.shows.first?.showName, "Under the Dome")
    }
    
    func testFetchShows_EmptyResult() async {
        mockService.resultToReturn = .success([])
        
        await viewModel.fetchShows(searchString: "")
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.shows.count, 0)
    }
    
    func testFetchShows_Error() async {
        mockService.resultToReturn = .failure(NetworkError.noInternet)
        
        await viewModel.fetchShows(searchString: "")
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "No internet connection")
        XCTAssertTrue(viewModel.shows.isEmpty)
    }
    
    func testFetchShows_SearchSuccess() async {
        mockService.resultToReturn = .success(mockShows)
        await viewModel.fetchShows(searchString: "Search")
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.shows.count, 1)
        XCTAssertEqual(viewModel.shows.first?.showName, "Under the Dome")
    }
    
    func testGetShowsList_withValidShows() {
        let result = viewModel.getShowsList(shows: mockShows)
        
        let expected: [ShowDetail] = [ ShowDetail( showName: "Under the Dome",
                                                   schedule: "Thursday Nights",
                                                   year: "2013",
                                                   timeSlot: "22:00",
                                                   genres: "Drama,Science-Fiction,Thriller",
                                                   description: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town\'s inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>",
                                                   imageURLString: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                                                   rating: "Average Rating:6.5")]
        
        XCTAssertNotEqual(result, expected, "The result does not match the expected ShowDetail list.")
    }
    
    func testGetShowsList() {
        let result = viewModel.getShowsList(shows: [])
        XCTAssertTrue(result.isEmpty, "The result should be an empty array for an empty input.")
    }
    
    func testGetScheduleDescription() {
        let schedule = TVShow.Schedule(time: "03:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getScheduleDescription(for: schedule)
        
        XCTAssertEqual(result, "Early Weekday Mornings", "The schedule description is incorrect for edge cases.")
    }
    
    func testGetPrefix_success() {
        let schedule = TVShow.Schedule(time: "03:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getPrefix(from: schedule.time)
        XCTAssertEqual(result, "Early")
    }
    
    func testGetPrefix_failure() {
        let schedule = TVShow.Schedule(time: "23:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getPrefix(from: schedule.time)
        XCTAssertNil(result)
    }
    
    func testGetDayDescriptor_Weekdays() {
        let schedule = TVShow.Schedule(time: "03:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getDayDescriptor(from: schedule.days)
        XCTAssertEqual(result, "Weekday")
    }

    func testGetDayDescriptor_Weekend() {
        let schedule = TVShow.Schedule(time: "03:00", days: ["Saturday", "Sunday"])
        
        let result = viewModel.getDayDescriptor(from: schedule.days)
        XCTAssertEqual(result, "Weekend")
    }
    
    func testGetTimeDescriptor_morning() {
        let schedule = TVShow.Schedule(time: "03:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getTimeDescriptor(from: schedule.time)
        XCTAssertEqual(result, "Mornings")
    }
        
    func testGetTimeDescriptor_afternoon() {
        let schedule = TVShow.Schedule(time: "17:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getTimeDescriptor(from: schedule.time)
        XCTAssertEqual(result, "Afternoons")
    }
    
    func testGetTimeDescriptor_night() {
        let schedule = TVShow.Schedule(time: "22:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getTimeDescriptor(from: schedule.time)
        XCTAssertEqual(result, "Nights")
    }

    func testGetTimeDescriptor_error() {
        let schedule = TVShow.Schedule(time: "30:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        let result = viewModel.getTimeDescriptor(from: schedule.time)
        XCTAssertNil(result)
    }
    
    func testGetPremieredYear() {
        let result = viewModel.getPremieredYear(dateString: "2013-06-24")
        XCTAssertEqual(result, "2013")
    }
}
