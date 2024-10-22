//
//  MovieDatabase.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//


import Foundation
class MovieDatabase {
    static let shared = MovieDatabase()
    
    private(set) var movies: [Movie]?
    
    private init() {
        loadMovies()
    }
    
    private func loadMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            print("Could not find movies.json file.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.movies = try decoder.decode([Movie].self, from: data) 
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
}
