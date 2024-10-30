//
//  MovieTests.swift
//  MovieDataBaseTests
//
//  Created by Gembali Sandesh Kumar on 22/10/24.
//

import XCTest
@testable import MovieDataBase // Import your app's module

class MovieTests: XCTestCase {

    func testMovieCodable() throws {
        // Sample JSON data
        let jsonData = """
        {
            "Title": "Inception",
            "Year": "2010",
            "Rated": "PG-13",
            "Released": "2010-07-16",
            "Runtime": "148 min",
            "Genre": "Action, Adventure, Sci-Fi",
            "Director": "Christopher Nolan",
            "Writer": "Christopher Nolan",
            "Actors": "Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page",
            "Plot": "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
            "Language": "English, Japanese, French",
            "Country": "USA, UK",
            "Awards": "Won 4 Oscars. Another 143 wins & 218 nominations.",
            "Poster": "https://example.com/poster.jpg",
            "Ratings": [
                {"Source": "Internet Movie Database", "Value": "8.8/10"},
                {"Source": "Metacritic", "Value": "74"}
            ],
            "Metascore": "74",
            "imdbRating": "8.8",
            "imdbVotes": "2,047,570",
            "imdbID": "tt1375666",
            "Type": "movie",
            "DVD": "N/A",
            "BoxOffice": "$836,836,967",
            "Production": "Warner Bros.",
            "Website": "N/A",
            "Response": "True"
        }
        """.data(using: .utf8)!

        // Decode the JSON data into a Movie instance
        let decoder = JSONDecoder()
        let movie = try decoder.decode(Movie.self, from: jsonData)

        // Assert the decoded values
        XCTAssertEqual(movie.title, "Inception")
        XCTAssertEqual(movie.year, "2010")
        XCTAssertEqual(movie.rated, "PG-13")
        XCTAssertEqual(movie.released, "2010-07-16")
        XCTAssertEqual(movie.runtime, "148 min")
        XCTAssertEqual(movie.genre, "Action, Adventure, Sci-Fi")
        XCTAssertEqual(movie.director, "Christopher Nolan")
        XCTAssertEqual(movie.writer, "Christopher Nolan")
        XCTAssertEqual(movie.actors, "Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page")
        XCTAssertEqual(movie.plot, "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.")
        XCTAssertEqual(movie.language, "English, Japanese, French")
        XCTAssertEqual(movie.country, "USA, UK")
        XCTAssertEqual(movie.awards, "Won 4 Oscars. Another 143 wins & 218 nominations.")
        XCTAssertEqual(movie.poster, "https://example.com/poster.jpg")
        XCTAssertEqual(movie.metascore, "74")
        XCTAssertEqual(movie.imdbRating, "8.8")
        XCTAssertEqual(movie.imdbVotes, "2,047,570")
        XCTAssertEqual(movie.imdbID, "tt1375666")
        XCTAssertEqual(movie.type, .movie)
        XCTAssertEqual(movie.boxOffice, "$836,836,967")
        XCTAssertEqual(movie.production, "Warner Bros.")
        XCTAssertEqual(movie.response, .responseTrue)
    }

    func testRatingCodable() throws {
        // Sample JSON data for Rating
        let jsonData = """
        {
            "Source": "Internet Movie Database",
            "Value": "8.8/10"
        }
        """.data(using: .utf8)!

        // Decode the JSON data into a Rating instance
        let decoder = JSONDecoder()
        let rating = try decoder.decode(Rating.self, from: jsonData)

        // Assert the decoded values
        XCTAssertEqual(rating.source, .internetMovieDatabase)
        XCTAssertEqual(rating.value, "8.8/10")
    }

    func testSortOrder() {
        // Test each sort order case
        XCTAssertEqual(SortOrder.titleAscending, .titleAscending)
        XCTAssertEqual(SortOrder.titleDescending, .titleDescending)
        XCTAssertEqual(SortOrder.yearAscending, .yearAscending)
        XCTAssertEqual(SortOrder.yearDescending, .yearDescending)
    }
    
    // You can add more tests for other models and functionalities as needed
}
