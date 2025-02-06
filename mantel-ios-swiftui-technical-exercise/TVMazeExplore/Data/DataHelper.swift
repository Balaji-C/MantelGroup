// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI
class DataHelper {
    static func populateTemporaryDataForPreview() async -> Result<[TVShow], Error> {
        return .success(
            [TVShow(
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
                )])
    }
}
