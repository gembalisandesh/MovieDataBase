//
//  MainViewModelTests.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 29/10/24.
//


import XCTest
import Combine
@testable import MovieDataBase

final class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var mockMovies: [Movie]!
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
        mockMovies = [
            Movie(title: "Movie One", year: "2022", rated: "PG-13", released: "01 Jan 2022",
                  runtime: "120 min", genre: "Action, Drama", director: "Director A",
                  writer: "Writer A", actors: "Actor A, Actor B", plot: "A plot",
                  language: "English", country: "USA", awards: "None", poster: "",
                  ratings: [], metascore: "80", imdbRating: "8.0", imdbVotes: "1000",
                  imdbID: "tt001", type: .movie, dvd: nil, boxOffice: nil, production: nil,
                  website: nil, response: .responseTrue),
            Movie(title: "Movie Two", year: "2021", rated: "R", released: "01 Jan 2021",
                  runtime: "90 min", genre: "Comedy", director: "Director B",
                  writer: "Writer B", actors: "Actor C, Actor D", plot: "Another plot",
                  language: "English", country: "USA", awards: "Won 1 award", poster: "",
                  ratings: [], metascore: "70", imdbRating: "7.5", imdbVotes: "500",
                  imdbID: "tt002", type: .movie, dvd: nil, boxOffice: nil, production: nil,
                  website: nil, response: .responseTrue)
        ]
        viewModel.movies = mockMovies
        viewModel.updateFilters()
    }

    override func tearDown() {
        viewModel = nil
        mockMovies = nil
        super.tearDown()
    }

    // Test movie loading
    func testLoadMovies() {
        XCTAssertEqual(viewModel.movies.count, mockMovies.count, "Movies should load correctly.")
    }

    // Test updating filters
    func testUpdateFilters() {
        XCTAssertEqual(viewModel.years, ["2021", "2022"], "Year filters should update correctly.")
        XCTAssertEqual(viewModel.genres, ["Action", "Comedy", "Drama"], "Genre filters should update correctly.")
        XCTAssertEqual(viewModel.directors, ["Director A", "Director B"], "Director filters should update correctly.")
        XCTAssertEqual(viewModel.actors, ["Actor A", "Actor B", "Actor C", "Actor D"], "Actor filters should update correctly.")
    }

    // Test search function with different inputs
    func testSearchMoviesByTitle() {
        let results = viewModel.getMoviesBySearch(searchTerm: "Movie One")
        XCTAssertEqual(results.count, 1, "Search by title should return correct movie.")
        XCTAssertEqual(results.first?.title, "Movie One", "Search should return the expected movie.")
    }

    func testSearchMoviesByGenre() {
        let results = viewModel.getMoviesBySearch(searchTerm: "Comedy")
        XCTAssertEqual(results.count, 1, "Search by genre should return correct movie.")
        XCTAssertEqual(results.first?.genre.contains("Comedy"), true, "Search should find the expected genre.")
    }

    func testEmptySearchReturnsAllMovies() {
        let results = viewModel.getMoviesBySearch(searchTerm: "")
        XCTAssertEqual(results.count, mockMovies.count, "Empty search term should return all movies.")
    }

    func testNoResultsForUnknownSearchTerm() {
        let results = viewModel.getMoviesBySearch(searchTerm: "Nonexistent")
        XCTAssertEqual(results.count, 0, "Unknown search term should return no results.")
    }
}

