//
//  MovieDatabase.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import Foundation

class MovieDatabase {
    static let shared = MovieDatabase()   // Singleton instance for global access
    
    private(set) var movies: [Movie]?     // Read-only array of movies
    var isTesting: Bool = false // New property to control testing behavior
    
    private init() {
        loadMovies()   // Loads movies on initialization
    }
    
    func loadMovies() {
        guard !isTesting else { return } // Skip loading real data in tests
        
        // Loads and decodes movies from a local JSON file
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            print("Could not find movies.json file.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.movies = try decoder.decode([Movie].self, from: data) // Decodes JSON to Movie objects
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
    
    func setMovies(forTesting movies: [Movie]) {
        self.movies = movies
    }
}
