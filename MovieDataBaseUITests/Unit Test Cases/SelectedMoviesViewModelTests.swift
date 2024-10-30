//
//  SelectedMoviesViewModelTests.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 30/10/24.
//


import XCTest
@testable import MovieDataBase

class SelectedMoviesViewModelTests: XCTestCase {
    
    var viewModel: SelectedMoviesViewModel!
    var movies: [Movie] = []
    
    override func setUp() {
        super.setUp()
        // Sample data for testing
        movies = [
            Movie(title: "The Godfather", year: "1972", rated: "R", released: "24 Mar 1972", runtime: "175 min", genre: "Crime, Drama", director: "Francis Ford Coppola", writer: "Mario Puzo, Francis Ford Coppola", actors: "Marlon Brando, Al Pacino", plot: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.", language: "English", country: "USA", awards: "Won 3 Oscars. Another 29 wins & 31 nominations.", poster: "", ratings: [], metascore: "100", imdbRating: "9.2", imdbVotes: "1,845,643", imdbID: "tt0068646", type: .movie, dvd: nil, boxOffice: nil, production: nil, website: nil, response: .responseTrue),
            Movie(title: "The Shawshank Redemption", year: "1994", rated: "R", released: "14 Oct 1994", runtime: "142 min", genre: "Drama", director: "Frank Darabont", writer: "Stephen King, Frank Darabont", actors: "Tim Robbins, Morgan Freeman", plot: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.", language: "English", country: "USA", awards: "Nominated for 7 Oscars. Another 19 wins & 38 nominations.", poster: "", ratings: [], metascore: "80", imdbRating: "9.3", imdbVotes: "2,359,150", imdbID: "tt0111161", type: .movie, dvd: nil, boxOffice: nil, production: nil, website: nil, response: .responseTrue),
            Movie(title: "Inception", year: "2010", rated: "PG-13", released: "16 Jul 2010", runtime: "148 min", genre: "Action, Adventure, Sci-Fi", director: "Christopher Nolan", writer: "Christopher Nolan", actors: "Leonardo DiCaprio, Joseph Gordon-Levitt", plot: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.", language: "English", country: "USA", awards: "Won 4 Oscars. Another 143 wins & 218 nominations.", poster: "", ratings: [], metascore: "74", imdbRating: "8.8", imdbVotes: "2,052,162", imdbID: "tt1375666", type: .movie, dvd: nil, boxOffice: nil, production: nil, website: nil, response: .responseTrue)
        ]
        viewModel = SelectedMoviesViewModel(movies: movies)
    }
    
    func testInitializationWithMovies() {
        XCTAssertEqual(viewModel.sortedMovies.count, movies.count)
    }
    
    func testSortingByTitleAscending() {
        viewModel.sortOrder = .titleAscending
        viewModel.refreshMovies()
        
        let sortedTitles = viewModel.sortedMovies.map { $0.title }
        XCTAssertEqual(sortedTitles, ["Inception", "The Godfather", "The Shawshank Redemption"])
    }
    
    func testSortingByTitleDescending() {
        viewModel.sortOrder = .titleDescending
        viewModel.refreshMovies()
        
        let sortedTitles = viewModel.sortedMovies.map { $0.title }
        XCTAssertEqual(sortedTitles, ["The Shawshank Redemption", "The Godfather", "Inception"])
    }
    
    func testSortingByYearAscending() {
        viewModel.sortOrder = .yearAscending
        viewModel.refreshMovies()
        
        let sortedYears = viewModel.sortedMovies.map { $0.year }
        XCTAssertEqual(sortedYears, ["1972", "1994", "2010"])
    }
    
    func testSortingByYearDescending() {
        viewModel.sortOrder = .yearDescending
        viewModel.refreshMovies()
        
        let sortedYears = viewModel.sortedMovies.map { $0.year }
        XCTAssertEqual(sortedYears, ["2010", "1994", "1972"])
    }
    
    func testApplySortAndHide() {
        viewModel.sortOrder = .titleDescending
        viewModel.applySortAndHide()
        
        XCTAssertFalse(viewModel.showSortOptions)
        XCTAssertEqual(viewModel.sortedMovies.map { $0.title }, ["The Shawshank Redemption", "The Godfather", "Inception"])
    }
}
