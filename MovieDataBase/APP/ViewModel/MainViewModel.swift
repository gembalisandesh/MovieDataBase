//
//  MainViewModel.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var movies: [Movie] = []           // Stores all movies to display
    @Published var years: [String] = []           // Unique years for filtering
    @Published var genres: [String] = []          // Unique genres for filtering
    @Published var directors: [String] = []       // Unique directors for filtering
    @Published var actors: [String] = []          // Unique actors for filtering
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadMovies()
    }

    private func loadMovies() {
        // Loads movies asynchronously to avoid blocking the main thread
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let loadedMovies = MovieDatabase.shared.movies {
                DispatchQueue.main.async {
                    self?.movies = loadedMovies
                    self?.updateFilters() // Updates filter options based on loaded movies
                }
            }
        }
    }

    private func updateFilters() {
        // Extracts unique years, genres, directors, and actors from the movies list
        years = Array(Set(movies.map { $0.year })).sorted()
        genres = Array(Set(movies.flatMap { $0.genre.components(separatedBy: ", ") })).sorted()
        directors = Array(Set(movies.flatMap { $0.director.components(separatedBy: ", ") })).sorted()
        actors = Array(Set(movies.flatMap { $0.actors.components(separatedBy: ", ") })).sorted()
    }
    
    func getMoviesBySearch(searchTerm: String) -> [Movie] {
        // Filters movies based on the search term across multiple attributes
        guard !searchTerm.isEmpty else { return movies }
        
        let searchTerms = searchTerm.lowercased().split(separator: " ")
        
        return movies.filter { movie in
            searchTerms.allSatisfy { term in
                let searchTerm = String(term)
                
                // Match checks against movie year, genre, director, actors, and title
                let yearMatches = movie.year.lowercased() == searchTerm ||
                    movie.year.lowercased().hasPrefix(searchTerm)
                
                let genres = movie.genre.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
                let genreMatches = genres.contains { $0.contains(searchTerm) }
                
                let directorMatches = movie.director.lowercased().contains(searchTerm)
                
                let actors = movie.actors.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
                let actorMatches = actors.contains { $0.contains(searchTerm) }
                
                let titleMatches = movie.title.lowercased().contains(searchTerm)
                
                return yearMatches || genreMatches || directorMatches || actorMatches || titleMatches
            }
        }
    }
}
