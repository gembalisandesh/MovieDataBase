//
//  MovieDatabaseTests.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 30/10/24.
//


import XCTest
@testable import MovieDataBase

final class MovieDatabaseTests: XCTestCase {
    
    var movieDatabase: MovieDatabase!

    override func setUp() {
        super.setUp()
        movieDatabase = MovieDatabase.shared
        movieDatabase.isTesting = true // Disable real data loading for testing
    }
    
    override func tearDown() {
        movieDatabase = nil
        super.tearDown()
    }
    
    func testSingletonInstance() {
        let secondInstance = MovieDatabase.shared
        XCTAssertTrue(movieDatabase === secondInstance, "MovieDatabase should be a singleton")
    }
    
    func testSetMoviesForTesting() {
        let mockMovies = [
            Movie(
                title: "Test Movie 1",
                year: "2024",
                rated: "PG",
                released: "2024-01-01",
                runtime: "120 min",
                genre: "Action",
                director: "John Doe",
                writer: "Jane Doe",
                actors: "Actor A, Actor B",
                plot: "A test plot",
                language: "English",
                country: "USA",
                awards: "None",
                poster: "https://example.com/poster1.jpg",
                ratings: [Rating(source: .internetMovieDatabase, value: "7.5")],
                metascore: "75",
                imdbRating: "7.5",
                imdbVotes: "10000",
                imdbID: "tt0000001",
                type: .movie,
                dvd: .nA,
                boxOffice: "10M",
                production: "Test Production",
                website: .nA,
                response: .responseTrue
            )
        ]
        
        movieDatabase.setMovies(forTesting: mockMovies)
        XCTAssertEqual(movieDatabase.movies?.count, 1, "Movies array should have one test movie")
        XCTAssertEqual(movieDatabase.movies?.first?.title, "Test Movie 1", "Title should match the mock data")
    }
    
    func testLoadMoviesWithRealData() {
        movieDatabase.isTesting = false // Allows `loadMovies` to proceed
        
        movieDatabase.loadMovies()
        XCTAssertEqual(movieDatabase.movies?.count, 19, "Movies should be nil if no JSON file is found")
    }
}
